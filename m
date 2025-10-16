Return-Path: <linux-aspeed+bounces-2478-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FB0CCD199
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Oct 2025 22:33:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnjRL5fWqz3cYr;
	Fri, 17 Oct 2025 09:33:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760591289;
	cv=none; b=dxh//Q5sM+WdnJhaKfd0DLEFXUGqNf1nTFT9iXVo6JC+UFp4kQfPShMlzVuanBOo+9NtAzF5GmvmrRanuuXuvyarnLnCWynI70tVklDnXHo7VBe72ZV224ie4y979OmjTa6ETYuhX/SfHTw5hj7qTTA7qcpLDdFWPx8B8nilOEaOrgKx+JA3+xaRL986cSvhfOuxrYoaIbgZAAa1q0SsIIrs/osdeOLWulM6Zwduut4Rp0a2QYjcGC/JmY5vHAFCqsZPBECBTLYJIuzRLbIEbDB6QwjzSmypsDt3RNzMYV3wJPpBKw9bmcL0vTt/5pRX0bX2FOAP+FUH6/QSqzulrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760591289; c=relaxed/relaxed;
	bh=SCAq3Tpy90yiw+VRqp/jzmhdqwWtKZRonlnTXaNao8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GsoWlN3Tbg5tndTfESBo+EUbygZiVmadoRs0zqiWeV69bjaM2kAcftYuieiBAgKMX8F3284Vc6Z7ZqzeaJF3SIAKCrSyHt/RQ0q5fFoUqW9pgYtlYjHfOSOjUQ4NafcLMY3oUbrUENdmgHk1qSxs4o11qHwF7wmkyUWT5m5KGrqlWf80DgwjAwkFrEw7AjvfHtiGX5juQQ6vKEeiC295x4bVlKMCeMtrlJDns7vJav2udFXT9yie97yVNDNhIfVZDvpLTvVfEyFQkSGalq9kAYxrGzaXSnqzVfTzslIjtEAlRyv41WPsbWQTc2IXKIDnT3YEhI6OmsFGrO3H6NxYwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=geBJxByL; dkim-atps=neutral; spf=pass (client-ip=91.218.175.172; helo=out-172.mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=geBJxByL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.172; helo=out-172.mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnGDj5mhDz2yqq
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Oct 2025 16:08:04 +1100 (AEDT)
Message-ID: <4db3bd26-1f74-4096-84fd-f652ec9a4d27@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760591263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SCAq3Tpy90yiw+VRqp/jzmhdqwWtKZRonlnTXaNao8c=;
	b=geBJxByLcvWBiujKOiaOahCqNyndVoWuu2mZ45TF8xE284+jE46+6ntqZCrEJOY3tjLJtS
	CA04TcSdtSgMTu+1LyL0JCiZYt8KyHlnhHzez+oDkOoqTGathzLcXzzn8tcestdiOMA31r
	Wv+r/T6z/ByuejbAoTutxC4uLBsXkfs=
Date: Thu, 16 Oct 2025 13:07:23 +0800
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
Subject: Re: [PATCH][v4] hung_task: Panic when there are more than N hung
 tasks at the same time
Content-Language: en-US
To: lirongqing <lirongqing@baidu.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, David Hildenbrand <david@redhat.com>,
 Florian Wesphal <fw@strlen.de>, Jakub Kacinski <kuba@kernel.org>,
 "Jason A . Donenfeld" <jason@zx2c4.com>,
 Joel Granados <joel.granados@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
 Liam Howlett <liam.howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Petr Mladek <pmladek@suse.com>, Phil Auld <pauld@redhat.com>,
 Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org
References: <20251015063615.2632-1-lirongqing@baidu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251015063615.2632-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

LGTM. It works as expected, thanks!

On 2025/10/15 14:36, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>

For the commit message, I'd suggest the following for better clarity:

```
The hung_task_panic sysctl is currently a blunt instrument: it's all
or nothing.

Panicking on a single hung task can be an overreaction to a transient
glitch. A more reliable indicator of a systemic problem is when multiple
tasks hang simultaneously.

Extend hung_task_panic to accept an integer threshold, allowing the kernel
to panic only when N hung tasks are detected in a single scan. This
provides finer control to distinguish between isolated incidents and
system-wide failures.

The accepted values are:
- 0: Don't panic (unchanged)
- 1: Panic on the first hung task (unchanged)
- N > 1: Panic after N hung tasks are detected in a single scan

The original behavior is preserved for values 0 and 1, maintaining full
backward compatibility.
```

If you agree, likely no need to resend - Andrew could pick it up
directly when applying :)

> 
> Currently, when 'hung_task_panic' is enabled, the kernel panics
> immediately upon detecting the first hung task. However, some hung
> tasks are transient and allow system recovery, while persistent hangs
> should trigger a panic when accumulating beyond a threshold.
> 
> Extend the 'hung_task_panic' sysctl to accept a threshold value
> specifying the number of hung tasks that must be detected before
> triggering a kernel panic. This provides finer control for environments
> where transient hangs may occur but persistent hangs should be fatal.
> 
> The sysctl now accepts:
> - 0: don't panic (maintains original behavior)
> - 1: panic on first hung task (maintains original behavior)
> - N > 1: panic after N hung tasks are detected in a single scan
> 
> This maintains backward compatibility while providing flexibility for
> different hang scenarios.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Florian Wesphal <fw@strlen.de>
> Cc: Jakub Kacinski <kuba@kernel.org>
> Cc: Jason A. Donenfeld <jason@zx2c4.com>
> Cc: Joel Granados <joel.granados@kernel.org>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> Cc: "Paul E . McKenney" <paulmck@kernel.org>
> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Phil Auld <pauld@redhat.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---

So:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
Tested-by: Lance Yang <lance.yang@linux.dev>

Cheers,
Lance

