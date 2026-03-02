Return-Path: <linux-aspeed+bounces-3581-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A7AEB3640
	for <linux-aspeed@archiver.kernel.org>; Mon,  2 Mar 2026 23:23:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPw3J610Xz3bnL;
	Tue, 03 Mar 2026 10:23:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772414252;
	cv=none; b=EbkmGDn5ie1OIHO/pJH4lxljS9oVOVinii+QYO/Z9AhoxCpIB4NM5JDv86utZtBLWO+VG/KYWPepu6cahaxVnL6G+9CgW6ox3uX3MEXQVv4TslSEhPwvTWb+nogCyDq2j7HnLUG4BZn0P0c6eXjn+vRTZBmOKnBWu24v0m9o98zjJwkDd/Z/OmaUW8/flcnFYaBjH81ixwLDIsrArmzRCwdbKHZpd/6nsk+U8HAYFIpJUxFOuRzVW57WBaJmZint/hAUIif3/Kb+Zql9012MiKfqE29qqp4jI/z3arUsuv6YIOABeVDjCQsKVfc+Blb4oionDAabexJousG5MuY5Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772414252; c=relaxed/relaxed;
	bh=IOB2Nx1FFQsmhOZ1L0aw7W6Ht+6NJ15/zle1Yf0fd5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amD+Yf0dAWwFZrdkbEREDua6dZm4fgpXzz9iSiIYx8NvE03sARq86WJxzw1wfEmCUIJK7sduHIFCJhGSbf+fs8ldVI5MlSPGAdG+m4O+m6SaguDU07a8tUnfJO8OWhaI4fqaDelGHOb0+yfJwSzayWLjQoYF3AuSMvHlMEgjbhdOvFTFX56xyVHapy9hVlwgnwkX9oPyMv692bwSLPpQJscf9zOntByAjC7rGALx4wIGXjk4VWbmH1mRvZ7YgGbjpAEtusMqc5JyYTBdmBEE788oZwviiu2ecPmNKZoIVhctfp1ODVhdL08AUNJcvuCbXxhs65oOjQmS54p+MR3mWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=qawb5h6m; dkim-atps=neutral; spf=pass (client-ip=117.135.210.5; helo=m16.mail.163.com; envelope-from=haiyuewa@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=qawb5h6m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.5; helo=m16.mail.163.com; envelope-from=haiyuewa@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPLdN5vXyz2xc8
	for <linux-aspeed@lists.ozlabs.org>; Mon, 02 Mar 2026 12:17:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=IOB2Nx1FFQsmhOZ1L0aw7W6Ht+6NJ15/zle1Yf0fd5Q=;
	b=qawb5h6mej9FkOXKCDUPFAThVxktWlRUKK4w8VWLpXapBeFFOpkODaBI8duc3v
	7vL4fvOFVqruEMrz8qmg96yxXrH+LBxhUXAhk3w92G32Ly48yQ2Hm0Y9gbw6ywLS
	WOIjS1IVHQ0Il88CUUeaqE2VJkCHXDw5A1MdKq2wvOuXg=
Received: from [192.168.11.65] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3nZoQ5aRpgA8OQw--.11S2;
	Mon, 02 Mar 2026 09:17:08 +0800 (CST)
Message-ID: <9674c8c6-4248-48f5-8669-93959484072d@163.com>
Date: Mon, 2 Mar 2026 09:17:03 +0800
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
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: ast2600: Add reset definition
 for video
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: linux-aspeed@lists.ozlabs.org, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hans Verkuil
 <hverkuil+cisco@kernel.org>, Jammy Huang <jammy_huang@aspeedtech.com>,
 "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260227151602.829-1-haiyuewa@163.com>
 <20260227-smooth-carefully-f427e242ce58@spud>
 <16a430a2-fdc9-41eb-945c-0727feb7b9d6@163.com>
 <20260228-entourage-awoke-92c61c5b1544@spud>
From: Haiyue Wang <haiyuewa@163.com>
In-Reply-To: <20260228-entourage-awoke-92c61c5b1544@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PygvCgD3nZoQ5aRpgA8OQw--.11S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFWxAFWrCF17AFy7ur18AFb_yoW8tF4DpF
	4YyF1kKr4UZFWFk3yIq3WxtFnYgw15JF15Wry5Xw1jv3Z0q3W2gr4IgrWUua4DWrs3ur12
	yF12qF9a9FyIvw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UxuciUUUUU=
X-Originating-IP: [116.233.47.41]
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/xtbC8BQCbWmk5RS9IwAA3p



On 2/28/2026 8:16 PM, Conor Dooley wrote:
> On Sat, Feb 28, 2026 at 09:20:56AM +0800, Haiyue Wang wrote:
>>
>>
>> On 2/28/2026 1:33 AM, Conor Dooley wrote:
>>> On Fri, Feb 27, 2026 at 11:13:14PM +0800, Haiyue Wang wrote:
>>>> Add ASPEED_RESET_VIDEO reset definition to the ast2600-clock binding
>>>> header. It is required for proper reset control of the video on the
>>>> AST2600 SoC for aspeed-video driver.
>>>>
>>>> Fixes: e83f8dd668ea ("media: aspeed: Fix dram hang at res-change")
>>>
>>> How can a binding change be a fix for a driver one?
>>>
>>
>> https://git.kernel.org/torvalds/c/9897831de614
>>
>> If squashed into one patch as v1 does, it will have patch format warning:
>> ./scripts/checkpatch.pl ...patch
>> WARNING: DT binding docs and includes should be a separate patch. See:
>> Documentation/devicetree/bindings/submitting-patches.rst
> 
> Adding a fixes tag implies that the change you have here should have
> been done in the patch you're citing. If you had done it in that patch,
> you would get a checkpatch warning there too. This is a separate change
> that is needed for your dts changes, but is not a fix for the driver
> change.
> 

 From this point of view, yes, a little strange to add "Fixes".

Drop this tag in V3, please review.

>>
>>>> Signed-off-by: Haiyue Wang <haiyuewa@163.com>
>>>> ---
>>>> v2:
>>>>     - Fix checkpatch.pl warning, and send dt-bindings as single patch as
>>>>       the submitting-patches guide.
>>>> v1: https://lore.kernel.org/all/20260227123837.70079-1-haiyuewa@163.com/
>>>> ---
>>>>    include/dt-bindings/clock/ast2600-clock.h | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
>>>> index f60fff261130..7b9b80c38a8b 100644
>>>> --- a/include/dt-bindings/clock/ast2600-clock.h
>>>> +++ b/include/dt-bindings/clock/ast2600-clock.h
>>>> @@ -124,6 +124,7 @@
>>>>    #define ASPEED_RESET_PCIE_RC_OEN	18
>>>>    #define ASPEED_RESET_MAC2		12
>>>>    #define ASPEED_RESET_MAC1		11
>>>> +#define ASPEED_RESET_VIDEO		6
>>>>    #define ASPEED_RESET_PCI_DP		5
>>>>    #define ASPEED_RESET_HACE		4
>>>>    #define ASPEED_RESET_AHB		1
>>>> -- 
>>>> 2.53.0
>>>>
>>


