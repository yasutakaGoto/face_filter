require 'faceapp'

client = Faceapp::Client.new
random  = Random.new

for i in 1..150 do
  p i
  
  # 読むファイルと、どのフィルタを使うかはランダム

  #ランダム抽出
  # ran_file = random.rand(1..99+i)
  # ran_filter = random.rand(0..4)
  # 
  # #固定抽出
  ran_file = i
  ran_filter = 1
  
  # どのファイルを読むか
  file_in = ran_file.to_s
  file = File.open(file_in + '.jpg', 'rb')

  # フィルタセット
  filter_set = ['hot', 'old', 'young', 'female', 'male']
  filter = filter_set[ran_filter]

  p "ファイル（" + file_in + "）, フィルタ（" + filter + "）"

  begin
    code = client.upload_photo(file) 

    result = client.apply_filter(code, filter)

    file_out = 150 + i
    output = File.open( file_out.to_s + '.jpg', 'wb')

    result = client.apply_filter(code, filter, output)
    # => File
    
    p file_out.to_s + ".jpg を出力"
  rescue
    p "ファイル（" + file_in + "）はエラー"
    
    file_out = 150 + i
    File.open(file_out.to_s + '.jpg', "w").close
    
    p file_out.to_s + ".jpg は空ファイルを作成"
  end
  
end
