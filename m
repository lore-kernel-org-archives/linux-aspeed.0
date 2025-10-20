Return-Path: <linux-aspeed+bounces-2534-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB572CCD199
	for <linux-aspeed@archiver.kernel.org>; Mon, 20 Oct 2025 09:59:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cqrWd1B1Yz2yjw;
	Mon, 20 Oct 2025 20:59:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760954397;
	cv=none; b=mdTPfwRWhbZmVo8E6eNo36/QLj630cvWDZP606D+eVZ47UYLMetEoY7f0EU7TuVIS2jYvTzGKzdGUrL7KzmJSBFlUPFix9CCqj75E3uKYKjKQ40/WIsxf0nmIjjUPekWnFmwodun58rkBXCDFg+nttncl8Ag2q4ObY5BEPhQBNPGiLxnzeUKDAg6oWWR2ps3Qf8vVxgPJ67c1dF6tpAFVMn34V4ywe1XZPEuHIuHI83vj26A1vL7+lPf6OMde7qqpdZFkjynoIQo22byHdokkBSLlgZL9ErWW1w1dmWma0r8qyDPSKo6nXv5hcnFYdFXAtAaoLzLytfsrk5VGf1u+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760954397; c=relaxed/relaxed;
	bh=Nv1tAHNC5rdzWwEmyrpfHnCrcnzP5XefZ6TCtA01IJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VaBlrL4iRQRIpluH+cTcs/2QrA1DBdOUTrDHCFQ1AUYwmiUEO+uTwsvsQYyAMxfxYIeA7UW92hFtwxfZttsjXoy6meyHuZC19ZBLqwwnaohaxd1wRhkOl5JejPAX+hZueiIUvQGrZ8qkkScmg9wfmgtuqSELmp+NtavPvYtehoCDj6ZGMyemO3LNycE1DdPQ6Nmc8kyHxw9uALatCehBJJWhHHjsyfFCpe0aU/u6freNszJumM+g6XPNLwn6FBSCKz56QlauT2lYOILNgOTtG6txoBA2l8Fes6CKLtzcQCkMPHktYn2zfrdTPBnPwP/pg5dJzk52JzZKLp1PhZEehQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ezqf3hMo; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ezqf3hMo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cqrWc11f1z2ySV
	for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Oct 2025 20:59:56 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CA0B741B6F;
	Mon, 20 Oct 2025 09:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B2DC113D0;
	Mon, 20 Oct 2025 09:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760954393;
	bh=ceTjqZxROGT4tCOsh4a1HC9zi9dJeNYU0qKQYBS6T/Y=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ezqf3hMoB5jnKPS4DJHG/Pg0w0CBMBhQb1Vb9ShbsVCoiTO85JRDSaCiHmsDHy5Ay
	 NpGG3pw/yqf3mEdbDn5x11ApurZUrQsRLExKcjhaEF+A685wwdCqtav1OKMnh/85jc
	 UbTXDmCBUO8b1Eb8il8CyLFeNWJp8cSMslkoatW3ODyl0xiYeosKW4XN1y+dEIoBpG
	 x9HSbhjU5W40P08avbwa3N9w7rDsGXA6os01LIa9Vcf+g1mbRLFwcBNLkCOVaqbGQi
	 ZM9rqGN8nNnQ6YepAZLoHI05hIPSp/bwIW6u2ByfBJRg3rocNyGBhwk3X18FoDIhrG
	 6/mJFOTxZ/G8w==
Message-ID: <fb986e30-9dfa-44c2-a395-418175d49b20@kernel.org>
Date: Mon, 20 Oct 2025 11:59:49 +0200
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
Subject: Re: [PATCH] dt-bindings: mfd: aspeed,ast2x00-scu: allow #size-cells
 range
To: Ryan Chen <ryan_chen@aspeedtech.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251020020745.2004916-1-ryan_chen@aspeedtech.com>
 <b38321e8-d243-460a-a9d6-6770a41627cd@kernel.org>
 <TY2PPF5CB9A1BE6CDC6F04CC0F472FE6451F2F5A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6b30c646-cc52-4552-8311-86974c1459e7@kernel.org>
 <e7fec714-aa68-49a1-85e5-356115843307@kernel.org>
 <TY2PPF5CB9A1BE65E96ED9C3CE0E8C7A53EF2F5A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <TY2PPF5CB9A1BE658D97FEB9B56E67534DCF2F5A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6cf7f86d-00f1-4939-aed0-4f97c1e0fd69@kernel.org>
 <TY2PPF5CB9A1BE6D5DF2D5348DAD6410D42F2F5A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <TY2PPF5CB9A1BE6D5DF2D5348DAD6410D42F2F5A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/10/2025 10:50, Ryan Chen wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: Monday, October 20, 2025 4:47 PM
>> To: Ryan Chen <ryan_chen@aspeedtech.com>; Lee Jones <lee@kernel.org>;
>> Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
>> Conor Dooley <conor+dt@kernel.org>; Joel Stanley <joel@jms.id.au>; Andrew
>> Jeffery <andrew@codeconstruct.com.au>; devicetree@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org; linux-aspeed@lists.ozlabs.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] dt-bindings: mfd: aspeed,ast2x00-scu: allow #size-cells
>> range
>>
>> On 20/10/2025 10:18, Ryan Chen wrote:
>>>> Subject: RE: [PATCH] dt-bindings: mfd: aspeed,ast2x00-scu: allow
>>>> #size-cells range
>>>>
>>>>> Subject: Re: [PATCH] dt-bindings: mfd: aspeed,ast2x00-scu: allow
>>>>> #size-cells range
>>>>>
>>>>> On 20/10/2025 08:39, Krzysztof Kozlowski wrote:
>>>>>> On 20/10/2025 08:31, Ryan Chen wrote:
>>>>>>>> Subject: Re: [PATCH] dt-bindings: mfd: aspeed,ast2x00-scu: allow
>>>>>>>> #size-cells range
>>>>>>>>
>>>>>>>> On 20/10/2025 04:07, Ryan Chen wrote:
>>>>>>>>> The #size-cells property in the Aspeed SCU binding is currently
>>>>>>>>> fixed to a constant value of 1. However, newer SoCs (ex.
>>>>>>>>> AST2700) may require two size cells to describe certain
>>>>>>>>> subregions or
>>>>>>>>
>>>>>>>> "may"? So there is no issue yet?
>>>>>>>
>>>>>>> while I submit ast2700 platform,
>>>>>>
>>>>>> So there is no warning currently? Then don't mention. You cannot
>>>>>> use argument of possible future warning as there is a warning
>>>>>> needing to be fixed. This makes no sense. Like you add bug in your
>>>>>> patchset and then send *different* patch claiming you are fixing a bug.
>>>>>>
>>>>>>
>>>>>>> These warnings appear when validating the AST2700 EVB device tree.
>>>>>>> The SCU nodes on AST2700 have subdevices (such as clock and reset
>>>>>>> controllers) that require two address cells, which is not allowed
>>>>>>> by the current `const: 1` constraint in the schema.
>>>>>>>
>>>>>>> Here is the related report:
>>>>>>>   https://lkml.org/lkml/2025/9/2/1165
>>>>>>
>>>>>> This must be together, so we can review entire picture, not pieces
>>>>>> by pieces. Organize your work correctly, so reviewing will be easy.
>>>>>>
>>>>> Anyway, I managed to find your original work and there is no need
>>>>> for this patch at all. You don't have 64-bit sizes there.
>>>> Thanks, I will keep #size-cells = <1>; for my next step.
>>>
>>> Hello Krzysztof,
>>> Sory bothers you again.
>>> After checking the AST2700 platform memory configuration, it supports
>>> up to 8GB of DRAM. This requires using `#size-cells = <2>` for the
>>> memory node, for
>>> example:
>>>
>>> 	memory@400000000 {
>>> 		device_type = "memory";
>>> 		reg = <0x4 0x00000000 0x0 0x40000000>;
>>> 	};
>>>
>>> Given this, what would be the proper way to proceed?
>>
>>
>> I did not comment on memory node. Maybe I looked at wrong node, not sure,
>> that's why this should not be discussed here but in that DTS patchset really.
> 
> Understood, thanks for the clarification.
> I'll move this discussion to the AST2700 DTS patchset and ensure that the
> binding and DTS changes are reviewed together there.
> 

The problem is that you refer to some very old patchset which is long
gone from our mailboxes. Sending a necessary change month after the DTS
patch is not making the discussion easy.

Please always think how your patchset is supposed to be reviewed.

Best regards,
Krzysztof

