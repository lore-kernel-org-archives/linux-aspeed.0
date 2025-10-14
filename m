Return-Path: <linux-aspeed+bounces-2444-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65456CCD184
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Oct 2025 21:59:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cmSmT1b4lz2xdg;
	Wed, 15 Oct 2025 08:59:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.181
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760442475;
	cv=none; b=DyPNQBEnqlnFOqp617T0eovV/2JNs3thUu+EN4kKu+tTxy34hS3YLYDYZ/TEe6ISKIlOWYnQ6ib29TfGW5kp9p1mfh5FZ/HxTUppS5RQY7qWxiPvak+9tpchpjyt2OATJNRthpiBGUSzN9hvTczKt4CA3Sh38oR/Lev5Q78Jt0FMlE5SlikN8NA/yNjxAZUAcsLw1ijG5oxL/HUwLO9+TWEtNo0v+1ZIjTr4s4T3AVVCmt7ryfKLPAeXtXH/Yt38ReV/IawcxRtH88mhjOl4x6qXIvsk8cf8GQlMoZoTaJsOVJ5jXNHwVH23NHQQE2zDYDLvxmD2Xljce7tXDJrgkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760442475; c=relaxed/relaxed;
	bh=Hd2PoIE+rPMCr6jd3OwU3he0uZl4CmPgrMZ61+ge710=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HW9XYRKrM9ulF4RS0uAeRw+dM/FmAInKUPFX2pTas3GRpTVZtr8qGmpFhMlGGRkAgglDpAX1GO7Dvv3wolDb2AvhF6kmQQhhL4YcktRiVsN6L7PyvipXneTX6e/24eT/XwaXHYLhf0xLC6R68l6fwCgOmHUdPUrmh2cIBsSoCKe8eTWZirPIuUJDyz45/dpPmB6uLFB3fkBec+om7lfRyx6CBn9RgemJkqJgMKCXzfcf8g4HnqO6/5vJIthTka411TYCl7iAitot3Mwkxz6dbQOMeVzVH5Uo2H7Hoc1jNfQP2pypNp+tcEvbRkqSaEhpzaNm4jNp5aGWQmEpBaQAig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VK9bY4Lu; dkim-atps=neutral; spf=pass (client-ip=95.215.58.181; helo=out-181.mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VK9bY4Lu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.181; helo=out-181.mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 380 seconds by postgrey-1.37 at boromir; Tue, 14 Oct 2025 22:47:52 AEDT
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmCBw6Xbvz3020
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Oct 2025 22:47:52 +1100 (AEDT)
Message-ID: <096168a6-8687-4dae-a774-0741d3e5a891@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760442070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hd2PoIE+rPMCr6jd3OwU3he0uZl4CmPgrMZ61+ge710=;
	b=VK9bY4LuIi4ji669KYN12TIOH35WJDu8pKASGIJSdi9qQhdHcSOS9ZOqAwGKpQPsCsa/MC
	Any8FgOqFuOI1eRpcwlhhwocJFbU9rKLsGQh3WYropHOaMHnqd5PxuOYzCW6qqbWxTyanS
	cCDvtJaYV62OHRnEZ5m/iARM6dBj9oQ=
Date: Tue, 14 Oct 2025 19:40:58 +0800
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
Subject: =?UTF-8?B?UmU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0hdW3YzXSBodW5nX3Rh?=
 =?UTF-8?Q?sk=3A_Panic_after_fixed_number_of_hung_tasks?=
Content-Language: en-US
To: "Li,Rongqing" <lirongqing@baidu.com>, Petr Mladek <pmladek@suse.com>
Cc: "wireguard@lists.zx2c4.com" <wireguard@lists.zx2c4.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 David Hildenbrand <david@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Russell King <linux@armlinux.org.uk>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
 Joel Granados <joel.granados@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Phil Auld <pauld@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Simon Horman <horms@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Florian Westphal <fw@strlen.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@linux.alibaba.com>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>
References: <20251012115035.2169-1-lirongqing@baidu.com>
 <588c1935-835f-4cab-9679-f31c1e903a9a@linux.dev>
 <aO4boXFaIb0_Wiif@pathway.suse.cz>
 <3acdcd15-7e52-4a9a-9492-a434ed609dcc@linux.dev>
 <38af4922ca44433fa7cd168f7c520dc9@baidu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <38af4922ca44433fa7cd168f7c520dc9@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/14 19:18, Li,Rongqing wrote:
>>>>> Currently, when 'hung_task_panic' is enabled, the kernel panics
>>>>> immediately upon detecting the first hung task. However, some hung
>>>>> tasks are transient and the system can recover, while others are
>>>>> persistent and may accumulate progressively.
>>>
>>> My understanding is that this patch wanted to do:
>>>
>>>      + report even temporary stalls
>>>      + panic only when the stall was much longer and likely persistent
>>>
>>> Which might make some sense. But the code does something else.
>>
>> Cool. Sounds good to me!
>>
>>>
>>>>> --- a/kernel/hung_task.c
>>>>> +++ b/kernel/hung_task.c
>>>>> @@ -229,9 +232,11 @@ static void check_hung_task(struct task_struct
>> *t, unsigned long timeout)
>>>>>     	 */
>>>>>     	sysctl_hung_task_detect_count++;
>>>>> +	total_hung_task = sysctl_hung_task_detect_count -
>>>>> +prev_detect_count;
>>>>>     	trace_sched_process_hang(t);
>>>>> -	if (sysctl_hung_task_panic) {
>>>>> +	if (sysctl_hung_task_panic &&
>>>>> +			(total_hung_task >= sysctl_hung_task_panic)) {
>>>>>     		console_verbose();
>>>>>     		hung_task_show_lock = true;
>>>>>     		hung_task_call_panic = true;
>>>
>>> I would expect that this patch added another counter, similar to
>>> sysctl_hung_task_detect_count. It would be incremented only once per
>>> check when a hung task was detected. And it would be cleared (reset)
>>> when no hung task was found.
>>
>> Much cleaner. We could add an internal counter for that, yeah. No need to
>> expose it to userspace ;)
>>
>> Petr's suggestion seems to align better with the goal of panicking on
>> persistent hangs, IMHO. Panic after N consecutive checks with hung tasks.
>>
>> @RongQing does that work for you?
> 
> 
> In my opinion, a single task hang is not a critical issue, fatal hangs—such as those caused by I/O hangs, network card failures, or hangs while holding locks—will inevitably lead to multiple tasks being hung. In such scenarios, users cannot even log in to the machine, making it extremely difficult to investigate the root cause. Therefore, I believe the current approach is sound. What's your opinion?

Thanks! I'm fine with either approach. Let's hear what the other folks 
think ;)


