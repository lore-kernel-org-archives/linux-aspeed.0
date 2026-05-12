Return-Path: <linux-aspeed+bounces-4015-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C56CD4855
	for <linux-aspeed@archiver.kernel.org>; Tue, 12 May 2026 08:45:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF9Cg2mYBz2yZc;
	Tue, 12 May 2026 18:45:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778575535;
	cv=none; b=lumsWn5visRDGGr38in7H1aaXR0d2DDRsHeeHCvxCqo+L5roVfMUZZ9GO2BGLxJroqJWqdjoo5CPCISUrkOXpFhY+iJrcSljfq1aICSIv88k5TKJZY4QZVhhDc3yT9tXlKki/Vp2LmYob02EWR+t8KCNHgXx+8veYxKLJJJe1CKli2gsCq/PgPhI/CgpCmEgv22L7bFF6wUGyO3NMBdX9fLhIIjxx7NTAx1uhLKhCRsDCH2Bh/NgZqFQX+kRdD4zUUUBlYxcdtnWgmoYopxuOehxVGb4DGzfY/2N1vSGObl5rw/hhpyjZv1ZZlSDk/kpDtIJD7dwG/gsbWcTNTeR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778575535; c=relaxed/relaxed;
	bh=hPjVjwBYUT81NbSYerPLbBR2nCY8Cy0J2Tk3EVZFcmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eSzAuV9pE261vfQzOLDPHSnW7wZmPNJNXyDcv2u2uA9XKCk7TamFl7G5S6M2W9p+QlHN+p7X4O1hinxxjTVRtWVW4AC9QfIKmOQhObXRWzcaAwHLpOmqPtZeGwBa1pRlYNPe0ITmV3+0j2UtTioGrndf08SegeiT9EvFQTlfyVYp99P0HZj9d+jJVXAzsOsSwAbO1k1Ogb1MvAvSoUfPfj1tLP4Lpfanihc2kTOVpGnr19Lc5mRpty4RncfqbM+i/XbyVq4ASRVWpZkT0bJ4FbgmCX9ltxylrs042Ut5v9hH0rVXCp9lp11XPasJsRxKWWS7SUymztljxPQj5//l+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nfe/WAhH; dkim-atps=neutral; spf=pass (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=oleksandr.shulzhenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nfe/WAhH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=oleksandr.shulzhenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF9Cb35WDz2yYs;
	Tue, 12 May 2026 18:45:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778575533; x=1810111533;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U6Bt7BPzzqflnmzTq2XYbmY9tMljGE473/5fyCg/9F4=;
  b=nfe/WAhHcwz8SiP97ii5jsqwG64foRU2y6ln7sPWJQSli/wccu2tYDs1
   C5ElDkls7mETtyCcx6Z4vcZbAmOClbclP0Q0AxT9N6oJV//6khu6s+iXs
   MBKOltzohOL2ZNWF00choWltS4MbfGfk/LA+0AKA+2TDWt/yuULaJY0KG
   bQjeLhV8r3tNbDMhnnU7MQhd9Q3FRECFUU+hyncNQR2cPW9IAOTnKP67G
   ntrpgr1m0BE8e2xPODnwbmRhnbkEjPRdJ9pDksIqVzSgUoZ7AlE4txI7V
   xMaOdfG1IaZce7nxniPxwG5KtgNWHgOWREpvBUaBTC/Z6RPJwgvmZzhyy
   A==;
X-CSE-ConnectionGUID: Fu2P8507T7iZkdNDaV3VVA==
X-CSE-MsgGUID: TEnHK/kLR1e0pmZHdNLYAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83093971"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83093971"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 01:45:26 -0700
X-CSE-ConnectionGUID: PV3dQ/zIRW6qGdQHawDNYw==
X-CSE-MsgGUID: z+cDrEW6SWejiepid5vlxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="233229580"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 01:45:25 -0700
Received: from [10.102.88.179] (oshulzhe-5CG4396S2Q.clients.intel.com [10.102.88.179])
	by linux.intel.com (Postfix) with ESMTP id 0933C20B5714;
	Tue, 12 May 2026 01:45:21 -0700 (PDT)
Message-ID: <be4f662a-b986-4b4c-8263-2fd7b63c238a@linux.intel.com>
Date: Tue, 12 May 2026 10:45:21 +0200
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
 <b1d56feb-9847-41b1-8bba-733963055cae@linux.intel.com>
 <KL1PR0601MB4276AB799EC03BB00C4C0E5490392@KL1PR0601MB4276.apcprd06.prod.outlook.com>
Content-Language: en-US
From: "Shulzhenko, Oleksandr" <oleksandr.shulzhenko@linux.intel.com>
In-Reply-To: <KL1PR0601MB4276AB799EC03BB00C4C0E5490392@KL1PR0601MB4276.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/12/2026 9:08 AM, YH Chung wrote:
> Hi Shulzhenko,
>
> Thanks for the follow-up.
>
>> Integrating this driver into the SPI subsystem may allow reusing some existing
>> definitions, e.g.|spi_controller|,|spi_message|, and perhaps parts related to
>> single/dual/quad I/O handling. At the same time, parts such as the Flash channel
>> (included in the current series), and OOB / Virtual Wire support (I would expect
>> to come later), appear to be specific to the Intel eSPI protocol. Modeling all of
>> that as just another SPI IP driver may introduce some awkward layering and
>> overhead.
> Agreed. eSPI introduces two additional pins, RESET# and ALERT#, beyond the
> standard SPI signals. More importantly, eSPI functionality is described
> primarily in terms of four logical channels, rather than generic low-level
> bus signaling or pure data transfers.
>
>> Also, the current series already seems to separate common eSPI logic from
>> AST2600-specific pieces, assuming that 2700 driver is also coming at some point.
>>
>> This makes me wonder whether a dedicated eSPI layer/subsystem could be a
>> better fit — either under the SPI or as something separate (but not SoC driver).
>>
>> Given my limited experience with SPI/eSPI, could you help clarify a few points for
>> me (and probably others as well)?
>>
>> * How much of the SPI subsystem can be reused for this implementation,
>> both for the current patchset and for likely future extensions?
> I believe only a limited portion of the SPI subsystem can be reused. Some
> generic framework elements, such as controller registration and basic
> scaffolding, may be useful initially. But this reuse appears to be mostly
> mechanical rather than semantic. Once eSPI-specific features like Flash
> channels, OOB messaging, and Virtual Wire semantics are involved, the SPI
> transaction model does not seem to map very naturally.
>
>> * Are there any pitfalls or abstraction mismatches in trying to reuse
>> the SPI core here?
> Our main concern is an abstraction mismatch. SPI is designed as a generic
> peripheral bus, while eSPI is more of a system-management interface with
> explicit host-BMC-specific semantics. Reusing the SPI core would likely
> require treating eSPI packets as generic bus-level transfers in the kernel.
>
> However, some eSPI transactions and protocol handling, such as LPC bridge
> accesses, are performed autonomously by the hardware rather than being fully
> driven as low-level bus operations by the driver. This makes the eSPI driver
> somewhat different from a conventional serial bus controller driver
> maintained under the SPI core.
>
Hi YH,

My main concern is trying to understand whether it is completely 
impossible (or introduces too much effort that we'd better not to take) 
integrating this to SPI subsystem.

 From your reply I understand there are two potential blockers:

a) Treating eSPI transfers as bus-level transfers (meaning that it will 
be necessary probably making separate driver for OOB/VW/Flash channels 
as they essentially use eSPI as a transport);

b) Some logic being done by the hardware (i.e. LPC bridge).

Please confirm my understanding:

(a) is feasible, but requires many effort to re-define architecture

(b) If something is done by the hardware - what is the driver impact? I 
recall eDAF use case when the driver wasn't involved at all - and flash 
access was fully done by the hardware (unless the controller is 
configured to handle it in SW mode).


P.S. I guess we can talk about host-BMC communication only when talking 
about hardware-dependent stuff (i.e. ast2600-espi files). eSPI core 
should be (it seems to be already is) at least BMC agnostic and this is 
the reason not having it under SOC/aspeed (ast2600-espi.* may stay here 
though).


