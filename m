Return-Path: <linux-aspeed+bounces-2445-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371ECCCD18E
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Oct 2025 21:59:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cmSmZ365mz2yGM;
	Wed, 15 Oct 2025 08:59:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.180
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760439588;
	cv=none; b=QHGB9B9OQpUQZRtPsp5PuqkEIDluphLNiH85EsQwpDd0zm6qAQV2bDt4U0MD9f1syYD25zzQ17YJCraG1ib++8zsMzAuL9v8RDaAR0giobB/91o2kiX+ysAGm6dotjVLwqld+h9cZkr/SQdeLUWs+TOfkpMMqIFQAlWLnVDVYyFhZWJcDeQgAN/ThqQoV8XCBD1hpvCjPDV8byzaTuIdJjKhw8dEdpF+Np6PLNy0gVDMX5lWH4EGfiRj0vL9szp202JjjmZWlIV8IIvj7iZzor9qpnFNsqczoliAW9K5Ny9WBCgxkcTaR769arlEPAuJoHuw94qrQ/cXEk3XAYubGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760439588; c=relaxed/relaxed;
	bh=bEvM+uhGgelsYNE930lxc/ZO1r9l2srRhYCoY59fvZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvQKm+1AbI1MQ0dtioku4ZrpsRIzINQrh8ThgAvDhdnxEReoknK/TGC07I7l8iGJVx1gkwxbeYAR55mNQAsAWSJrf6Y/hGLcy4Ch156SD9kwTc3pSOkAiD9FantEhBJOTgDxGB6P8dlsX9ZnHfFRvxh8sMeNWI+4xte0fWqVtIvN+9sVcGZKI5HaJe43627W/Srju3YGB6ozUDSr3pXctvgHAA53pmEUfhwa+6WwKY+d1lqwrezWPIzi/PubxKur2UU60DS0GtO/ADNhYm+vdCguAbVvWmUIkOhbMEJoahJR3k7pAL2I161mtLAjJXKupCMk6648HcX2htgD43pq3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BiR+m8sa; dkim-atps=neutral; spf=pass (client-ip=91.218.175.180; helo=out-180.mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BiR+m8sa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.180; helo=out-180.mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 20106 seconds by postgrey-1.37 at boromir; Tue, 14 Oct 2025 21:59:45 AEDT
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmB7P6qDlz3cQx
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Oct 2025 21:59:43 +1100 (AEDT)
Message-ID: <3acdcd15-7e52-4a9a-9492-a434ed609dcc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760439559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bEvM+uhGgelsYNE930lxc/ZO1r9l2srRhYCoY59fvZI=;
	b=BiR+m8sacQLfJamWviP0aUJZSo9wnpjGz6QYPqt/6NI9DNz9xzTtXzaORvGO75k6ieWkbU
	ejrTjgascTaQ7moGN5ndS+DY7Tu/xY5mjJ4yJdKB476LoOWOBTkmiB8iYkbkn8w6lCrro9
	LY1hD72GCumzUMDh8YXWz5v0H039po4=
Date: Tue, 14 Oct 2025 18:59:07 +0800
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
Subject: Re: [PATCH][v3] hung_task: Panic after fixed number of hung tasks
To: lirongqing <lirongqing@baidu.com>, Petr Mladek <pmladek@suse.com>
Cc: wireguard@lists.zx2c4.com, linux-arm-kernel@lists.infradead.org,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-doc@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-aspeed@lists.ozlabs.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Russell King <linux@armlinux.org.uk>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
 Joel Granados <joel.granados@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Phil Auld <pauld@redhat.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Simon Horman <horms@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@linux.alibaba.com>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>
References: <20251012115035.2169-1-lirongqing@baidu.com>
 <588c1935-835f-4cab-9679-f31c1e903a9a@linux.dev>
 <aO4boXFaIb0_Wiif@pathway.suse.cz>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <aO4boXFaIb0_Wiif@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/14 17:45, Petr Mladek wrote:
> On Tue 2025-10-14 13:23:58, Lance Yang wrote:
>> Thanks for the patch!
>>
>> I noticed the implementation panics only when N tasks are detected
>> within a single scan, because total_hung_task is reset for each
>> check_hung_uninterruptible_tasks() run.
> 
> Great catch!
> 
> Does it make sense?
> Is is the intended behavior, please?
> 
>> So some suggestions to align the documentation with the code's
>> behavior below :)
> 
>> On 2025/10/12 19:50, lirongqing wrote:
>>> From: Li RongQing <lirongqing@baidu.com>
>>>
>>> Currently, when 'hung_task_panic' is enabled, the kernel panics
>>> immediately upon detecting the first hung task. However, some hung
>>> tasks are transient and the system can recover, while others are
>>> persistent and may accumulate progressively.
> 
> My understanding is that this patch wanted to do:
> 
>     + report even temporary stalls
>     + panic only when the stall was much longer and likely persistent
> 
> Which might make some sense. But the code does something else.

Cool. Sounds good to me!

> 
>>> --- a/kernel/hung_task.c
>>> +++ b/kernel/hung_task.c
>>> @@ -229,9 +232,11 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>>>    	 */
>>>    	sysctl_hung_task_detect_count++;
>>> +	total_hung_task = sysctl_hung_task_detect_count - prev_detect_count;
>>>    	trace_sched_process_hang(t);
>>> -	if (sysctl_hung_task_panic) {
>>> +	if (sysctl_hung_task_panic &&
>>> +			(total_hung_task >= sysctl_hung_task_panic)) {
>>>    		console_verbose();
>>>    		hung_task_show_lock = true;
>>>    		hung_task_call_panic = true;
> 
> I would expect that this patch added another counter, similar to
> sysctl_hung_task_detect_count. It would be incremented only
> once per check when a hung task was detected. And it would
> be cleared (reset) when no hung task was found.

Much cleaner. We could add an internal counter for that, yeah. No need
to expose it to userspace ;)

Petr's suggestion seems to align better with the goal of panicking on
persistent hangs, IMHO. Panic after N consecutive checks with hung tasks.

@RongQing does that work for you?

