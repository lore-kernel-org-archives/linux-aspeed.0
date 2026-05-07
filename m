Return-Path: <linux-aspeed+bounces-4008-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD4FCD343F
	for <linux-aspeed@archiver.kernel.org>; Thu,  7 May 2026 16:01:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBH6M2Sksz2xQC;
	Fri, 08 May 2026 02:00:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778169659;
	cv=none; b=GbiftT49lRYyk1eZk6kDFjdq9+Us4RknttR+IwDg42BBRd8kiDsdvHAoAiaRAHxaidcaPYyd+YZ2A7HbPDlJ8e7MnliyL+8CL4LNBGauESEQoH1i32F2V4p/vSulCVDs0nyxittqkiFRtQA0uzLCjH8LBvdIeEcBMCdFr4yGliRzubPrHAtqefknmFd8oNty6+lN5YW3KuJm6N+VkSxDFSuvug2PdEWDz39lv40VgE2kdZHpoZVvhxykhL4ywAbxB/2rmq9uKmdrXp3Drsu/sO1UfUjDFJywUfDu08YePz3diBIOx6ZamL393a2aKhb0P5kq7HkcZEK4R/a3/eCCBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778169659; c=relaxed/relaxed;
	bh=jgziH4kIZ7vCwuDFMy2H2sa/DZNDXnfB805FtgBuIlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GGIknmgzkExzmO3jWJRiPzQ0hg3tKOFhiR4tFWj3DOE2MH4haMRKc351yM+uKepC9iVVJaeAWi7+NNHsf9jbe6z7hWOxwpQymbBkcUAtnoc6NieKuwmGg5fbKzd1MLZSHPVs1dys9DupRACKFruLNy9qnhzVlW0Wh/bC7erW1+693teK50n22R04qGdwGcABnw7WGsnD+0GSchDFg/9zYQRdUJl+ZJVWzAHngksTMbPQZUVvmq7BSX0HPRcp5hFUSHZxEq4VFU2ocLyuRk3dayakxxkajTsSAHQbNoJRGP3zknsSwFdD8AcIzQvAfIxWdBwqdeVLiLvTe4v5jKRTMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kDGC/hTm; dkim-atps=neutral; spf=pass (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=oleksandr.shulzhenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kDGC/hTm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=oleksandr.shulzhenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBH6H5LQQz2xPb;
	Fri, 08 May 2026 02:00:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778169656; x=1809705656;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8BPtm1ERjnpYkkfFpMlDgHXX0eJd4mOVQdjMNGpCaCY=;
  b=kDGC/hTmw1/cPwt9R2lcqhuNw/UnTC/qhQTb/pHxrlSDFjUv4GlfnQA4
   0wGxt1h2+0+bWDL6a7bMvufo5HTITp2yEOaMTuJMasAXc1tE7f4YNfnha
   H5YpS5zorbTj5bqCGZli+aEUtRKePulJv70YXp5mxaIRgJQp1w/SqDZ7y
   GSkZF7hWLDuLV5z6cxqWrJgY/+q4ktHq48V+y7JSC9zKAtg9MjAdPa9V1
   TRulq0WsqcrvK4VGjJs2YXigmU2wYu8gDDnS8LuFOP1AhO1yWyitZnDIv
   YBixbJv0Xvtc8dHsSDjDzZIemVn+7vxoQ/yXuz5p61WInHtQyah/d1tHO
   A==;
X-CSE-ConnectionGUID: POzmfRygTOuZ3Kpls8h9gA==
X-CSE-MsgGUID: 6v0rlNsvTEqRByOhvSHhew==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90502277"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="90502277"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 09:00:50 -0700
X-CSE-ConnectionGUID: W8JdCnF+Q1ynh0P7UD8UIg==
X-CSE-MsgGUID: mY5sbussT2WvLYe2eD1VnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="266870993"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 09:00:50 -0700
Received: from [10.246.17.81] (unknown [10.246.17.81])
	by linux.intel.com (Postfix) with ESMTP id 9DE2F20B5713;
	Thu,  7 May 2026 09:00:46 -0700 (PDT)
Message-ID: <b1d56feb-9847-41b1-8bba-733963055cae@linux.intel.com>
Date: Thu, 7 May 2026 18:00:45 +0200
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
Subject: Re: [PATCH 0/7] soc: aspeed: Add AST2600 eSPI controller support
To: YH Chung <yh_chung@aspeedtech.com>, Arnd Bergmann <arnd@arndb.de>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Philipp Zabel
 <p.zabel@pengutronix.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
 "maciej.lawniczak@intel.com" <maciej.lawniczak@intel.com>,
 Mark Brown <broonie@kernel.org>
References: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>
 <20260313-energy-casket-ca8adc1f1fd1@spud>
 <23909400-4e7f-49c9-a982-14036372af98@app.fastmail.com>
 <c3b28ee92fa46700887d0c68b23045b2418358a7.camel@codeconstruct.com.au>
 <KL1PR0601MB4276ED93723F0B1F42349AD89041A@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <0f7f0f96-a918-47d5-a0bd-bbde494c8fed@app.fastmail.com>
 <KL1PR0601MB4276B5BE3B96C18E3A66AD709049A@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <14870d17-2471-4522-b8b5-03cb9002a4f7@app.fastmail.com>
 <KL1PR0601MB42763DAD359305DEBA4B769D9057A@KL1PR0601MB4276.apcprd06.prod.outlook.com>
 <KL1PR0601MB427603A6A5768D6A537CAFCB905AA@KL1PR0601MB4276.apcprd06.prod.outlook.com>
Content-Language: en-US
From: "Shulzhenko, Oleksandr" <oleksandr.shulzhenko@linux.intel.com>
In-Reply-To: <KL1PR0601MB427603A6A5768D6A537CAFCB905AA@KL1PR0601MB4276.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/7/2026 11:36 AM, YH Chung wrote:
> Hi Arnd,
>
> Thanks for the comments and questions.
>
>> These all seem to be viable options, but I still think we should focus on
>> agreeing on a design for the low-level hardware interface and whether this
>> can or should be abstracted between SoC vendor specific drivers before
>> trying to solve the user interface side.
>   
> Could you share your thoughts on whether it would make sense to accept our
> eSPI driver as is, and whether it should live under the SoC vendor-specific
> directories? Any comment would be greatly appreciated.
>
> Thanks,
> YunHsuan

Hi YunHsuan,

Let me add my 5 cents on this matter.

Integrating this driver into the SPI subsystem may allow reusing some 
existing definitions, e.g.|spi_controller|,|spi_message|, and perhaps 
parts related to single/dual/quad I/O handling. At the same time, parts 
such as the Flash channel (included in the current series), and OOB / 
Virtual Wire support (I would expect to come later), appear to be 
specific to the Intel eSPI protocol. Modeling all of that as just 
another SPI IP driver may introduce some awkward layering and overhead.

Also, the current series already seems to separate common eSPI logic 
from AST2600-specific pieces, assuming that 2700 driver is also coming 
at some point.

This makes me wonder whether a dedicated eSPI layer/subsystem could be a 
better fit — either under the SPI or as something separate (but not SoC 
driver).

Given my limited experience with SPI/eSPI, could you help clarify a few 
points for me (and probably others as well)?

  * How much of the SPI subsystem can be reused for this implementation,
    both for the current patchset and for likely future extensions?
  * Are there any pitfalls or abstraction mismatches in trying to reuse
    the SPI core here?

I think this would help make the subsystem placement discussion much 
clearer.



