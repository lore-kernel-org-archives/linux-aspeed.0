Return-Path: <linux-aspeed+bounces-3563-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E29CFD0072
	for <linux-aspeed@archiver.kernel.org>; Mon,  2 Mar 2026 00:16:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPKHM6kYhz2xR4;
	Mon, 02 Mar 2026 11:16:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772205698;
	cv=none; b=jJ+GH43J4KgF81cJ5135ecayqi1vUcvcY7BFeN8VtdNw0PNhlWRn+Ta9TkUF6aTkj48fu9CGIy+pdVsNei3C5eCQcIecrNqFdaJdjF+8E6shrVc6TZ/7FMhOLH4AGW2nCSjk4YVFrPvUBKxfnG4E3EmMlIuxke9dnwy7MqTfGS8GxOrtTXuZKvBt7wDCFlA0Vqc7RotbmG9U7G+lWr0mmiqF+ioXNfjvx2ZDZdUgYKTI9dnwxo3BWHjVAn9LMG2IVNb1+8ilTt9DDNsE91v5hdjLkdBV4E3cy0lPxN8U9ximLaGkG/x4O1oGq9YH4WwPU011FXA2mjcCJ/rdblYK6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772205698; c=relaxed/relaxed;
	bh=fEivCrRLEaWubps/mZfSJBqMglR1LXHtXAurk5Wm9Cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ze3QZ7IcoKkYlI0TsjG48afuuihVPqcyY2NMx4mhtDyUFZcjhBiSOfWj8dyBuc/Q7fJZ/sOrI6vnkWAaGZwHPe7IL0idn0PgY3SDCbPYKoqGn1D+kyZfB0z/NnLnM55p84rO3jo2fNYuPNZ2WwiVlIogsoozlnvVM9KYyEJGExO81AKtOymQeWyj4mgQ1TsIst7wQDFHJK+3bseyktsItEUZWwVNTachStbIxmsxDFUz1xGjODw5/DgSMCyV/2hPYZdRXhqmYfQzU7PGitFILDemLMZBC1BQ/9WNA28pxhkLjar342xsJfEN7A3I363eRnBeUUOHYib0R0qlAhE14Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=fjZ2GVkV; dkim-atps=neutral; spf=pass (client-ip=220.197.31.4; helo=m16.mail.163.com; envelope-from=haiyuewa@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=fjZ2GVkV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.4; helo=m16.mail.163.com; envelope-from=haiyuewa@163.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 140 seconds by postgrey-1.37 at boromir; Sat, 28 Feb 2026 02:21:36 AEDT
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMsVm6bJwz2xYw
	for <linux-aspeed@lists.ozlabs.org>; Sat, 28 Feb 2026 02:21:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=fEivCrRLEaWubps/mZfSJBqMglR1LXHtXAurk5Wm9Cc=;
	b=fjZ2GVkVN90vPOj+6lHylLNlax6CPw93DXU+VKgMTKFI5RXke/RMWERoTb4b0u
	VtvhAM4iPjcmS/xFZOg9Bqc6zJI9aB/LBKjZvnBGZM+5Fg/kwxSmUofoLdtbT/MT
	bNOTmqyG/Y2PrOYx6WRiKvXDxrFGgkTZChoXgFwUB1L8g=
Received: from [192.168.1.104] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3H2C3taFpheHENA--.55136S2;
	Fri, 27 Feb 2026 23:18:15 +0800 (CST)
Message-ID: <0bc7875c-106c-48e1-8d40-72919ca227c4@163.com>
Date: Fri, 27 Feb 2026 23:18:13 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] media: aspeed: Fix driver probe failure
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-aspeed@lists.ozlabs.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>,
 Jammy Huang <jammy_huang@aspeedtech.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ASPEED MACHINE SUPPORT"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
References: <20260227123837.70079-1-haiyuewa@163.com>
 <8060fe77-18ec-4aa0-90a1-50eee398a55b@kernel.org>
From: Haiyue Wang <haiyuewa@163.com>
In-Reply-To: <8060fe77-18ec-4aa0-90a1-50eee398a55b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3H2C3taFpheHENA--.55136S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFW8Ww47Cw4xuFWDGF1UGFg_yoW8CFyfpa
	y8ua1DKrZ3KF1YkayxJa4xtFyUZws0yFs8trW5J347X3s8Xw1FqrWSyrWv9rWDJrs5u347
	tFW8K34vgr4YqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U59N3UUUUU=
X-Originating-IP: [101.228.113.192]
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/xtbC7xheyWmhtbi8bgAA33



On 2/27/2026 8:59 PM, Krzysztof Kozlowski wrote:
> On 27/02/2026 13:38, Haiyue Wang wrote:
>> The aspeed video (be compatible for ast2400, ast2500, ast2600) now needs
>> the reset DTS handle specified, otherwise it will fail to load:
>>
>> [    0.000000] OF: reserved mem: initialized node video, compatible id shared-dma-pool
>> [    0.000000] OF: reserved mem: 0xbb000000..0xbeffffff (65536 KiB) map reusable video
>> [    0.377039] videodev: Linux video capture interface: v2.00
>> [    4.809494] aspeed-video 1e700000.video: irq 57
>> [    4.809977] aspeed-video 1e700000.video: Unable to get reset
>> [    4.810341] aspeed-video 1e700000.video: probe with driver aspeed-video failed with error -2
>>
>> Fixes: e83f8dd668ea ("media: aspeed: Fix dram hang at res-change")
>> Signed-off-by: Haiyue Wang <haiyuewa@163.com>
>> ---
>>   arch/arm/boot/dts/aspeed/aspeed-g4.dtsi   | 1 +
>>   arch/arm/boot/dts/aspeed/aspeed-g5.dtsi   | 1 +
>>   arch/arm/boot/dts/aspeed/aspeed-g6.dtsi   | 1 +
>>   include/dt-bindings/clock/ast2600-clock.h | 1 +
> 
> Please run scripts/checkpatch.pl on the patches and fix reported
> warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
> patches and (probably) fix more warnings. Some warnings can be ignored,
> especially from --strict run, but the code here looks like it needs a
> fix. Feel free to get in touch if the warning is not clear.
> 
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> 

Seperated into two patches in v2, please help to review.

>>   4 files changed, 4 insertions(+)
> 
> 
> Best regards,
> Krzysztof


