require 'ltp_checker'
def get_checklist(word,rank,btfidf, bltp, bchineselsa)
  if bltp ==true
    ltp = LTP.check_ltp(word)[0,rank.to_i]
  end
  if bchineselsa == true
    chineselsa = LTP.check_chineselsa(word)[0,rank.to_i]
  end
  if btfidf == true
    tfidf = LTP.check_tfidf(word)[0,rank.to_i]
  end
  mixed = Hash.new{ |h,k| h[k] = Hash.new(&h.default_proc) }
  0.upto(rank.to_i-1) do |i|
    if btfidf == true
      mixed[word]["tfidf"][tfidf[i][0]]=tfidf[i][1]
    end
    if bchineselsa == true
      mixed[word]["chineselsa"][chineselsa[i][0]]=chineselsa[i][1]
    end
    if bltp ==true
      mixed[word]["ltp"][ltp[i][0]]=ltp[i][1]
    end
  end
  mixed
end

print get_checklist("男人",10,false,true,true)
