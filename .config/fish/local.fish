# note: this should NOT be added to the git repo


function ansa-staging
	pgcli postgresql://ansa:iLsyR0ZHadBgKWJG@staging-web-pg.ctxfctysmbsh.us-east-1.rds.amazonaws.com:5432/ansa --ssh-tunnel ubuntu@staging
end

function supabase-staging
	PGPASSWORD='zk*0*#Nd!IIgND8s' pgcli  -h db.zqktqjoqwgxpszfvrwfm.supabase.co -p 5432 -d postgres -U postgres
end
