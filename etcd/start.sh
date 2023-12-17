#!/bin/bash
OUT_PATH=${OUT_PATH:-'/opt/etcd/backups'}
out_name=$(date "+%Y-%m-%d,%H:%M:%S")

echo `date +"%Y-%m-%d %H:%M:%S"`
echo '......开始备份数据库......'
mkdir -p ${OUT_PATH}
if [[ -z "$CERT" ]]; then
  etcdctl --user ${USER} --password ${PASSWORD} --endpoints=${ENDPOINTS} snapshot save ${OUT_PATH}/${out_name}
else
  etcdctl --cacert ${CACERT} --cert ${CERT} --key ${KEY} --endpoints=${ENDPOINTS} snapshot save ${OUT_PATH}/${out_name}
fi
if [ $? != 0 ];then
  echo "......导出数据失败......\n\n"
  exit 1
fi

cd ${OUT_PATH}
num=$(ls ./ | wc -l)

for dir in $(ls ./)
do
  if [ $num -le 1 ];then
            break
  fi
  rm -rf $dir
  num=$(($num-1))
done

echo `date +"%Y-%m-%d %H:%M:%S"`
echo "......备份结束......\n\n"

echo `date +"%Y-%m-%d %H:%M:%S"`
echo "......打包并上传至cos开始......\n\n"

tar -czvf ${OUT_PATH}/${out_name}.tar.gz ./${out_name}
if [ $? != 0 ];then
  echo `date +"%Y-%m-%d %H:%M:%S"`
  echo "......打包失败......\n\n"
  exit 2
fi

coscmd config -a ${SECRET_ID} -s ${SECRET_KEY} -b ${BUCKET_NAME} -r ${REGION} -p 100
coscmd upload ${OUT_PATH}/${out_name}.tar.gz ${COS_PATH}/${out_name}.tar.gz
if [ $? != 0 ];then
  echo `date +"%Y-%m-%d %H:%M:%S"`
  echo "......上传失败......\n\n"
  exit 3
fi
echo `date +"%Y-%m-%d %H:%M:%S"`
echo "......上传结束......\n\n"
