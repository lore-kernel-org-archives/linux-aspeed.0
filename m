Return-Path: <linux-aspeed+bounces-3912-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F9DF433CC
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Apr 2026 23:59:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwym62TVvz2yrT;
	Thu, 16 Apr 2026 09:59:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776277330;
	cv=none; b=n95H33v14et/G8oUaZufyN8DtMmvQlgTQtlDid2IMwqQQOgNF3LDqxrLmlakMb/T6OMEKMKDmTXel2Nb1WJEwSMIJ49DUJE25gNVkpxTSnEc47kxezs/tyB8+rO+Tf/lcZ3mN+jqteZ3oy8QYYWNErTfV3e+VcCUkntjoBuRUE0kxEBVVbtOQ7fn51mPh9hart6qM4hhyIh3j94mMgLRv7pNIr5ldKbn8qpLbmr1OTKXq2XLOcvsp20TzVpdMEduN/BWpHxgTeFFLKj6ZPMc43kiWTYiBZno9ImP/G9yxTnEwvRM/zdpzFQQTJz47B0equzMKmzNm0dyaQsm1Y2c/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776277330; c=relaxed/relaxed;
	bh=ZsW85w2UgN7W0CGdTdAcPBBf5104xaQ7TM/wOyf4dRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kOxaZBK9G2ev3Hp0rqHeeG+2lUAcpeJmrcl1sdtzGkWvVe9HeuvpFsUWp04gSkM88FFKUceZC18xXbEFz59GFvEAb6YOmOb3rSKff3sWXmaHAqcXuLujtdbHXSVW5hn1yCoLkXegmaFriU7CYpj5EnUZwLk6eCQ9NNLY+X+XLoPNZcCbVaFUUmUwyxZsSxM/dITw1s48T0k4Nvk0JkN3GXbViA1lhoHS3idrW90adJXuChWcxc53EZ6Hn1sXhyVUmbN63h/ZasCDiy9ZL+9mZsbcwLaezSqrQmGEZtCDhO1Dpd4vBFL1r5X5PsjlIOCuemWhXMSDfFxvJitp/Frq5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kBCOMFwE; dkim-atps=neutral; spf=pass (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kBCOMFwE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwqHM3rynz2yj1
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Apr 2026 04:22:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776277328; x=1807813328;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H7jvNxMoyDOskGYfx3Wf2OxswmTnEl9blys24JcUhHc=;
  b=kBCOMFwEVWMrDLRwaYajQoHt6f1ybPbFXUnITXcu3sOE6olj1Vl+xwur
   MMHAm0f6BFJymPhCDNTrfSzrHM4+H5jbsNO56UL866yTLdGlF8VdLtEvx
   LTzc/vjRu2kaYeP6yVqed13OE99MKtJcMFKmfJyjLPfaYi/+Rc+g88VSe
   4K9mEfAaYDUsj6YjF4NVi9IToRktdVeQKLCtD0kmXNRtUAzyuHDZrNRvr
   Ted2ZHkvGFpJsjMnoDjjTLceS3oswqivGgmI6R1WnD6niuTlygl9M8JSQ
   yHdnez5E/N5ycPZbAhQAza3HMzl+A6BLBVkGiMwW3opnGag+KT1IV066b
   w==;
X-CSE-ConnectionGUID: 1abjjtKmT72HYxshVhTKzQ==
X-CSE-MsgGUID: 2SO7CqGTRgu3qLL47sFOgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77141904"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77141904"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 11:22:00 -0700
X-CSE-ConnectionGUID: scLcZlr2RIyw2mcbKX1FTQ==
X-CSE-MsgGUID: Xa+s81DcRsK9kV8uVfWbYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="234524620"
Received: from dawidgla-mobl.ger.corp.intel.com (HELO [10.94.250.17]) ([10.94.250.17])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 11:21:57 -0700
Message-ID: <cb0d16bf-988d-403e-8a8e-c85bf2a208d0@linux.intel.com>
Date: Wed, 15 Apr 2026 20:21:48 +0200
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
Subject: Re: [PATCH v3 3/3] dt-bindings: i3c: Add AST2600 I3C global registers
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, linux-aspeed@lists.ozlabs.org,
 linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>,
 Maciej Lawniczak <maciej.lawniczak@intel.com>
References: <cover.1775679285.git.dawid.glazik@linux.intel.com>
 <7f55458097ef651b4fc46650254afd3fa7b87348.1775679285.git.dawid.glazik@linux.intel.com>
 <20260409-beneficial-sociable-tamarin-dbcaeb@quoll>
 <d74e7aa8-1110-469a-ac7e-3829c2458852@kernel.org>
Content-Language: en-US
From: Dawid Glazik <dawid.glazik@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <d74e7aa8-1110-469a-ac7e-3829c2458852@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/2026 9:30 AM, Krzysztof Kozlowski wrote:
> On 09/04/2026 09:28, Krzysztof Kozlowski wrote:
>> On Wed, Apr 08, 2026 at 10:34:35PM +0200, Dawid Glazik wrote:
>>> Introduce the device-tree bindings for I3C global registers found on
>>> AST2600 SoCs.
>>>
>>> Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>
>>> ---
>>> I wasn't sure if I should add newline at the end of the
>>> file or not so I took
>>> https://github.com/torvalds/linux/tree/master/Documentation/devicetree/bindings/i3c
>>> as an example.
>>
>> Answer is: you cannot have patch warnings.
>>
>> Documentation/devicetree/bindings/i3c does not have patch warning, does
>> it?
> 
> And if you tested this code with standard tools, you would see that...
> 
> Best regards,
> Krzysztof

Thank you for the review and feedback. This is my first contribution to 
Linux kernel so I'm still learning the process and toolchain. I 
apologize for the rookie mistakes. I will address all the issues you've 
pointed out and resubmit the series.

Best regards,
Dawid

