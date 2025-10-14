Return-Path: <linux-aspeed+bounces-2436-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0608CCD187
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Oct 2025 09:45:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cm8TR0pgXz3cQx;
	Tue, 14 Oct 2025 20:45:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760435115;
	cv=none; b=cJSuLpEFSL5Wxsg/BVr/HfDlWtBulCG5kQnuR///r/ZURbqEE9oecdfuZsEzdXFjlUikbrEzuFYG3jLCqjo53SlnK8UuyYsSU15bIuiXkj0g7p8DMwvPuYs+C3kIeL326pRgVKn27GhmNvKC2qxWDs+ZC+JOhPgaeFinsH6tr6Ij1D7ZpCZxMstsEm5bY4mCwOmNrIkCXyYy4feMBOGhhFPTEJxzwU5d4nKtji0tSUjtPnkKAh29jBcNyBjOf3FSIONLZknwxbkMNMtiv/WS89GKWqrHFJ6GmWZScjrwGTaamUAKC3cuUXv5kbflGPSAaiq/L2pgOE2EYpCdj/5nOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760435115; c=relaxed/relaxed;
	bh=R75CvrIgcbILYeZyEie2SvMudL4DW8xIUI8yCH+RsPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibFn9maHs5xo4qqR2nrq7hZDBTYHKPv8p3Kx25wbEmNvMKz2aHR2BepE8uLYkOYCa9aAmc7whj6dVRR9R0pK5gFMKkkxCz6Mj1hCmg08a0sqWm6NUM/GZ3I5v574dxViegMSyGt23owauLcZfSdm8sLaTvpKg4myE67uZ5Qqw/3R9h+XiVgnJadqmIGZRiALs9y1vtXACtg2v3eVpB27QVQdWpEwVekhnEjsTmRiULQZG+Ftm4DghnkxB7sF09ywgjn0gNGTYAmslLQOglXareIhjIzYruVuoIKeaWpeTM2I2Y1Nc5wgZi/1cAujCk9fxIDhiLKD2MmPgxqZ4lrjzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Wvig9hMn; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Wvig9hMn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cm8TN3TG6z2yrZ
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Oct 2025 20:45:11 +1100 (AEDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so30601425e9.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Oct 2025 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760435108; x=1761039908; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R75CvrIgcbILYeZyEie2SvMudL4DW8xIUI8yCH+RsPE=;
        b=Wvig9hMn5r5GdDHD3XzQYv8YOdCO9pbcLYG+nVrPF3lmwnPD65B4vR+sUR5AmEOvA6
         dIYVvxYWiGU0v7W2gqwoLihmrDx8vjKlfgGDdje5aZTgBsEAsKOL1kcQlQrsgrCNJ95v
         uH2ioadi9KnLPbt1+v64CgHrohQDzVBMQo1yJJ9ZNH1SDEWfzUthzGA3VHNNOladcGkV
         n0TQg3e/E44GfZmzZPNNa3Fhm9UrD3/oFS5HETXhXczVkxafqetHa+6VcVSMPxpZZ7kj
         6HyLaJH8NHpv65KY+hamKhR9s8ZwLRKuIX+ONC6sf+xzwWbv8bVM8BdwX7iWCMuiw/N6
         zP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760435108; x=1761039908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R75CvrIgcbILYeZyEie2SvMudL4DW8xIUI8yCH+RsPE=;
        b=Yf78gi+1bj11QxiVn0CkBnDp0igjaXe1lLyucgZnYAAGqlBEFLDmJuLclQRLrmLWyP
         tlEGxBh2fXYH6FS5dsIyvKraVcAfJDru+2Z8rqqWh/7MePxGSf/CZ8cY16SvLb6WseKl
         mMBsFLwc2w0DzaHne3NfF0/C8i32DvCdSf8k4H5aZyLMubOvRhxt70mgnAdgEqSdPdcU
         edDN9gLlqhZYXgwC5cV1wZ2b+BLHYmHqgOjxEwAZ3IyGTUBAXYr7WqEZGYZrcmlKPS/M
         0wCEi0Bu7KbaLpSOyd1JnB39Q1Ga342hbBBhaCam505tWd+779PSKSVfhEkZDfXkKGNz
         vfVw==
X-Forwarded-Encrypted: i=1; AJvYcCXBbElaHNn714vmZ5plqaUykHxn75iAzxIEtd0Kj/AMQhVLNQh6RlMpkBIlQnhJxl5r0mVM5Mmiu8goOjg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwEZzr3WJvTvwvNVsC50Q7obz0TvwKl4hEULnV+ErsDfB6rlKHl
	1SqpR9gyEU/E/llm2TLAVkxjh+RhJ0q5MQFQ/+gr5uO1BlJrrncWqbXCMgzZ2d/ltT4=
X-Gm-Gg: ASbGnctGS/bGKiO6Ae3dlWO13vlXxfHAjN4hCC0TNq3UxsvfANC91nXAkBKmWkGY6BZ
	SlgSZvHeirPfUfaQpfCOOb662BhB4e3Xn0mE5hCcSd8GUy9P57Sr7hNafdRxJG+cbv3tmYSAXjN
	crC2shJ1QJQbJsISC52annUfbctle14AZ9gLhHMTbdps9nDiWUMe6Id+6dnwF7A1aRugbjIwnCK
	E7KbGtifXU8SVL1qQ7QL9ZPKb9KCOnCARHxBO41v7WPLzA71WVX4/RGy3AvoQOLUKvw1OEa6Cmy
	G7I45Q4gAvNrr73LYUysZ3GgQEXrjXfOQRcsN6hZZJs+VU4RnxmeuXZtPmLMhNxuNrq7CpB+cbP
	7Xs3M6ppyuikl4Q/08tZ2gjd/61o98k19lHQpDh7oIt/1+qbL4JjEJHqvoNCQPjcdzb80hQ==
X-Google-Smtp-Source: AGHT+IFLMF/oRlSecQb1AgZUj9ViudEM8BAiQCOLkhiN8cHZAWDwJ7zBbTzbicn8TdmEii38ZLu7Sw==
X-Received: by 2002:a05:600c:890d:b0:46e:32f7:98fc with SMTP id 5b1f17b1804b1-46fa9af3656mr132535685e9.21.1760435107774;
        Tue, 14 Oct 2025 02:45:07 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489ad27sm230711415e9.15.2025.10.14.02.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:45:07 -0700 (PDT)
Date: Tue, 14 Oct 2025 11:45:05 +0200
From: Petr Mladek <pmladek@suse.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: lirongqing <lirongqing@baidu.com>, wireguard@lists.zx2c4.com,
	linux-arm-kernel@lists.infradead.org,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	linux-doc@vger.kernel.org, David Hildenbrand <david@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stanislav Fomichev <sdf@fomichev.me>, linux-aspeed@lists.ozlabs.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>, Russell King <linux@armlinux.org.uk>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Joel Granados <joel.granados@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH][v3] hung_task: Panic after fixed number of hung tasks
Message-ID: <aO4boXFaIb0_Wiif@pathway.suse.cz>
References: <20251012115035.2169-1-lirongqing@baidu.com>
 <588c1935-835f-4cab-9679-f31c1e903a9a@linux.dev>
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
In-Reply-To: <588c1935-835f-4cab-9679-f31c1e903a9a@linux.dev>

On Tue 2025-10-14 13:23:58, Lance Yang wrote:
> Thanks for the patch!
> 
> I noticed the implementation panics only when N tasks are detected
> within a single scan, because total_hung_task is reset for each
> check_hung_uninterruptible_tasks() run.

Great catch!

Does it make sense?
Is is the intended behavior, please?

> So some suggestions to align the documentation with the code's
> behavior below :)

> On 2025/10/12 19:50, lirongqing wrote:
> > From: Li RongQing <lirongqing@baidu.com>
> > 
> > Currently, when 'hung_task_panic' is enabled, the kernel panics
> > immediately upon detecting the first hung task. However, some hung
> > tasks are transient and the system can recover, while others are
> > persistent and may accumulate progressively.

My understanding is that this patch wanted to do:

   + report even temporary stalls
   + panic only when the stall was much longer and likely persistent

Which might make some sense. But the code does something else.

> > --- a/kernel/hung_task.c
> > +++ b/kernel/hung_task.c
> > @@ -229,9 +232,11 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
> >   	 */
> >   	sysctl_hung_task_detect_count++;
> > +	total_hung_task = sysctl_hung_task_detect_count - prev_detect_count;
> >   	trace_sched_process_hang(t);
> > -	if (sysctl_hung_task_panic) {
> > +	if (sysctl_hung_task_panic &&
> > +			(total_hung_task >= sysctl_hung_task_panic)) {
> >   		console_verbose();
> >   		hung_task_show_lock = true;
> >   		hung_task_call_panic = true;

I would expect that this patch added another counter, similar to
sysctl_hung_task_detect_count. It would be incremented only
once per check when a hung task was detected. And it would
be cleared (reset) when no hung task was found.

Best Regards,
Petr

