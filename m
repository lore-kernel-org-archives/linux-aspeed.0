Return-Path: <linux-aspeed+bounces-2438-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871BBCCD192
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Oct 2025 13:09:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cmF0t5T8Bz3bW7;
	Wed, 15 Oct 2025 00:09:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760447358;
	cv=none; b=ntHWqk8MCNByRHB+9flLjj6/surFyeF4RTchHyxAbrM4cICaRqFR6eKWHzLKquYYCCHJ6+gGBhN5kxI+iEawgXPlnOkbH00qzQR0CQx0a5Ysm1KBt1dOcYV39PjmEQwtms5J5b6Tr6XlCfsc1zGFBnuYDEHPXGg6eeyypIPDcWCd7oBoXTjeQA1FbvlbFv6hnHLCqK6MtFl32mpOUHg3z5B7gScsL+08ptA/d6tb48W9AUFA5ItGo5l1I5QrsyapRLvFE3Enc1rkMuQY3I9Ceq138Voul3rejRLbePNs9RqYThVtQuLrD20DKBxwUGBhOo7sz5mB3MeRwfjgdNczuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760447358; c=relaxed/relaxed;
	bh=XBmndkyEtmuH2zqfJVf2MipvEX2Eu2YJsa5R9Svl5+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHbZ7VEFF6rtOAuvEpIrMR6xTt/MKHXyKJGtR+vRrVPJPvazlHHujcQOP7TWuXeOP4OD/q0DCyKMGwHsm3gLAwM/EbToiyJo349Yt/E8p7+lvZZpzaiE6UGQ+TgnpiExERJVsYSNMoVrj7F815rJQcdxr40mU0hX7w8nVAGsWFjM4UhfHIMSCaULNc3OM7L91p58X7rnBWNb5U8vIwl5lzTSOAKxiDQTGbkLFS8hconDSa6K3zHrlZrkKt/5p084BLETSKn2VUjnWW0nx95O8D6NgjWRl1ADpO/VP8AzRXTPBpF4Q6djDFT0smdGnzF1f85FC+YoOcUt4ark8/snMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Nd+ZlOYm; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Nd+ZlOYm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmF0s2HVfz30V1
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Oct 2025 00:09:16 +1100 (AEDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-421851bcb25so2448603f8f.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Oct 2025 06:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760447353; x=1761052153; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XBmndkyEtmuH2zqfJVf2MipvEX2Eu2YJsa5R9Svl5+o=;
        b=Nd+ZlOYmTYGDZRk9h3HO11/sG4ve8MJ/zJfflLbC/iH8iLAuiH/UgvA6xyA7Mp1J8B
         KBgAwdnLBvuxdRvUdGbMKwC3Rb++CRmYQktNc/Qluxddf6Sa/0Phcu8GHuFqEBvh27s4
         v1VdTo4pCMVM78eg3NPrs0d6cqPLtLi8dKw2OW+iSy7XPXZrtqUjerafzk+Hj5dpqNeV
         vS05TNTDPYKHPfSWDBcVoGN3YCz1FdIryur2Xlb1cYT/7fv1IktQL+CudRaISBwu2m1m
         f7jVnL2h7MeL6HTwGvEdsHFpDKKNFHIvugElNkpJLCFyadz2Nc5ZY2vB+e7lGm7uHR0i
         8ZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760447353; x=1761052153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBmndkyEtmuH2zqfJVf2MipvEX2Eu2YJsa5R9Svl5+o=;
        b=QorH6wEXncM87J3/5d1AyO1JEsBxd2I0uwd3icF8ZGhZhjdMP8V8euQcntlbAiKCym
         xmNNScjgSd0kvVhAIJI+PtBCDbhRR7M6nOzE41xyhfWeX3wbF+W8v9vIZZtpaVnGKtVU
         AqIyrTCKbrfbaZfR13mIri2+onA644sGr+HXzaoMOfKgwvyVnOMvk9vX5X7zg6vHUUd4
         RwMyaKfIG4lH/iAEpFX9uDN0jLlaMBJAc/3midtA+1DE5LpFZcg2aZeFhAYyl8JQfRcw
         ez/ARV7fKEPcbvAIgloK+4WEci0yqfQh+bbWtKFCffgjgo69ynL7+KjgPsbbNHaVJK40
         b1FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzfSdMdPR0+6zpvl2k5WZEmD2s5ofFaN/uFJ47YPAd06scDmRVFHvl04J/Qujpjd+TU6ZdEybRCuEXSvA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzAELDjLClhOjfC573gSFpf6uCP3+BKRatOg3cDM5e7BzYq95EA
	40ywFxrFiBb8OfDnYkTqc3wQvkxTxJNGkAcsqFMyCTo8WA5AnRwK9k/CDLNZzUlfwfw=
X-Gm-Gg: ASbGncv6v82J9igFua5mHdV4/pelUVcC5Yn4FqDQLADDoj7tEf9+kr5mAhjQB2RopfQ
	e/mY9FYJTbBZN3kAMsq2i7KLEa8L8Q+Nb4grB77t9lC8xwAFx0UfJ4Lu5LMj4gTfWXoYII/0+Rx
	Pmjh7xo+MnD7276dIOfoZn/lMV+gh6VQyTp3s39cRi+jlrlXeMcUVt0vfFgLapH6DgFvBaoVJ65
	LYaeUCmSvh5Yo4nRQHBt4OxgUv749UBMunek62L8hxNdt7nR6dlLQ/KiPhOgh0dwBfyECuam79/
	P37+TqYFpz0IcKCByo0cCHocnOWMQKBnMmGDkxdvCmheHI8L2Qs7pEjRxRSl+PpHr/arX+Hj0qy
	jfdYl4Jy8FZ0UuD+13M5N6AWSVh9M20ty+fHvUv4PsfAsLmw8Ahhy/TjCvAtDHqgF1IFciw==
X-Google-Smtp-Source: AGHT+IFGpYfRWYGhqIaSZxufyw3cU/D950Wt8EiMNsuJCAolvX6QytVu1nn4m6ZLSmt3VXgOJE+wuQ==
X-Received: by 2002:a05:6000:43d4:20b0:426:ed9d:4072 with SMTP id ffacd0b85a97d-426ed9d43d7mr1534097f8f.21.1760447352714;
        Tue, 14 Oct 2025 06:09:12 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cf70fsm22846162f8f.27.2025.10.14.06.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:09:12 -0700 (PDT)
Date: Tue, 14 Oct 2025 15:09:10 +0200
From: Petr Mladek <pmladek@suse.com>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: Lance Yang <lance.yang@linux.dev>,
	"wireguard@lists.zx2c4.com" <wireguard@lists.zx2c4.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>, Russell King <linux@armlinux.org.uk>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Joel Granados <joel.granados@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Phil Auld <pauld@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Florian Westphal <fw@strlen.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [????] Re: [PATCH][v3] hung_task: Panic after fixed number of
 hung tasks
Message-ID: <aO5Ldv4U8QSGgfog@pathway.suse.cz>
References: <20251012115035.2169-1-lirongqing@baidu.com>
 <588c1935-835f-4cab-9679-f31c1e903a9a@linux.dev>
 <aO4boXFaIb0_Wiif@pathway.suse.cz>
 <e3f7ddf68c2e42d7abf8643f34d84a18@baidu.com>
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3f7ddf68c2e42d7abf8643f34d84a18@baidu.com>

On Tue 2025-10-14 10:49:53, Li,Rongqing wrote:
> 
> > On Tue 2025-10-14 13:23:58, Lance Yang wrote:
> > > Thanks for the patch!
> > >
> > > I noticed the implementation panics only when N tasks are detected
> > > within a single scan, because total_hung_task is reset for each
> > > check_hung_uninterruptible_tasks() run.
> > 
> > Great catch!
> > 
> > Does it make sense?
> > Is is the intended behavior, please?
> > 
> 
> Yes, this is intended behavior
> 
> > > So some suggestions to align the documentation with the code's
> > > behavior below :)
> > 
> > > On 2025/10/12 19:50, lirongqing wrote:
> > > > From: Li RongQing <lirongqing@baidu.com>
> > > >
> > > > Currently, when 'hung_task_panic' is enabled, the kernel panics
> > > > immediately upon detecting the first hung task. However, some hung
> > > > tasks are transient and the system can recover, while others are
> > > > persistent and may accumulate progressively.
> > 
> > My understanding is that this patch wanted to do:
> > 
> >    + report even temporary stalls
> >    + panic only when the stall was much longer and likely persistent
> > 
> > Which might make some sense. But the code does something else.
> > 
> 
> A single task hanging for an extended period may not be a critical
> issue, as users might still log into the system to investigate.
> However, if multiple tasks hang simultaneously-such as in cases
> of I/O hangs caused by disk failures-it could prevent users from
> logging in and become a serious problem, and a panic is expected.

I see. This another approach and it makes sense as well.
An this is much more clear description than the original text.

I would also update the subject to something like:

    hung_task: Panic when there are more than N hung tasks at the same time



That said, I think that both approaches make sense.

Your approach would trigger the panic when many processes are stuck.
Note that it still might be a transient state. But I agree that
the more stuck processes exist the more serious the problem
likely is for the heath of the system.

My approach would trigger panic when a single process hangs
for a long time. It will trigger more likely only when the problem
is persistent. The seriousness depends on which particular process
get stuck.

I am fine with your approach. Just please, make more clear that
the number means the number of hung tasks at the same time.
And mention the problems to login, ...

Best Regards,
Petr

