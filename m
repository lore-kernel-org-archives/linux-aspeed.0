Return-Path: <linux-aspeed+bounces-4012-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346CECD4855
	for <linux-aspeed@archiver.kernel.org>; Mon, 11 May 2026 23:51:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDxMB2K1dz2yCL;
	Tue, 12 May 2026 09:51:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778508886;
	cv=none; b=YrSujpj7ffWCrYrxeHMeQMIx4I21IJ2OBDjbzzdI2yuqWTabOhacYICLnxkuVdz+rvBhn533KTY+xm6HZYFu95AC1/YozczYfKIYQEdk0GhmfkrXfJtQFdVnxlu6QVqcljn6EmRIk8PK6nusoKCaJjE5cSmXEcBJW68mq9//s53BgAdIg7FYaS+4/zykMLsBdWh8DDNUsBGiAC+PTzRHw6L8KxhM9ldpvVCSbrt9cwwXEDDewx+FSBsAZMXfgoUnJnqUha+Wax1UzbENbDXV8sigaVKU2lfUAPR0TFilGXuteMedFrKuvB8VGAUDdkE5OSCahYWR39HaRB5pNGQusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778508886; c=relaxed/relaxed;
	bh=RbzBamjzxXiVtpHrqv9CMUVENI1ThdjIF2HinA6vwbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lK2khUcTbIoWqMmh00tLG6VzK8SsHhUyFesFOigmVgs0ExMO5UU2VT4sOCHOLMRZRewcmxV6T8pcb8LHa1qkaX7Hi0W5K781tLWSGIApNZWYrMTXmMY29glWduBtFNHsPxr0fRbxNxa1eeiKDnP/T65Wy39jNvo1uto3k655ZnBgjXEWVswZNyMuYVX56J/8b3zAExXYnevCTtUnu0zlHy19Mf8Z5epHxAVnZroZlSPZX7RWiV5w8OCxJ6EDDRuAcDWiVOGguEvlSOQ4UUK4bP9zAMeUQJi/rXCqdf1pRCgpLFOQdQuY/piuktKXpA3/bqN8zy47rCShaWqwhOT+Gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L345XV9b; dkim-atps=neutral; spf=pass (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L345XV9b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDhYv0bMDz2y8F
	for <linux-aspeed@lists.ozlabs.org>; Tue, 12 May 2026 00:14:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778508883; x=1810044883;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/xqH7NH5OnIsXIFChpqYZdEouHpjFOVq5k8bHoem5oY=;
  b=L345XV9b+nkCD0qgzrYBW8B0FNu7YrYjrrTyX/TBWKVai9GDsPj3CBER
   n7HpFpDNyvqpQVS0/LeqAOruo2oyf3HdUBJkntGFC71gfQNm9FCam5Hft
   O8U+x4fqw/iqO8cF1rYmKWFF6Sgz8K8W5uzyd8cIzQG+ZZf14gi3yVm7U
   wUp/KOkKWv4SzOp/Zs3BLTKSfxxZ3NsMvX5vupgcWcJ//m4sHSpOgRa6f
   ALR75OT7ezXuNc3VI2yE8Xz8oYzp3fMJEs7Pqs7Mv9uoLGdhBv2eN878s
   yzFfFMYSJmwxOtL/KH+5TtW3W68uNxrptgpuXePwOGlvCKu65S7Q4iZTN
   w==;
X-CSE-ConnectionGUID: 9xtyGhlESjyFjtPHRd47mg==
X-CSE-MsgGUID: +IORggLaQTuR86Za3RwJ0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79577332"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79577332"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 07:14:37 -0700
X-CSE-ConnectionGUID: IGMkto1nQuq+i2PCwp8hSg==
X-CSE-MsgGUID: joc20km3Sn+zISkQ0Tcj4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="232986212"
Received: from dawidgla-mobl.ger.corp.intel.com (HELO [10.94.250.159]) ([10.94.250.159])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 07:14:34 -0700
Message-ID: <15956b70-c6c2-4e3d-8f15-471a274d6e2d@linux.intel.com>
Date: Mon, 11 May 2026 16:14:25 +0200
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
Subject: Re: [PATCH v4 0/3] ARM: dts: aspeed-g6: add AST2600 I3C nodes and
 bindings
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, maciej.lawniczak@intel.com
References: <cover.1777058942.git.dawid.glazik@linux.intel.com>
Content-Language: en-US
From: Dawid Glazik <dawid.glazik@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <cover.1777058942.git.dawid.glazik@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/2026 10:20 PM, Dawid Glazik wrote:
> This series reworks and resubmits AST2600 I3C DTS updates that were
> originally posted in 2024, but stalled without further upstream
> progress.[1] The series was rebased onto the current tree and merge
> conflicts were resolved.
> 
> The patches first move I2C controller nodes under the APB simple-bus
> for layout consistency, then document aspeed,ast2600-i3c-global in
> the syscon binding, and finally add AST2600 I3C controller nodes in
> aspeed-g6.dtsi.
> 
> Jeremy agreed in a separate email thread that I can continue this
> series under my authorship.
> 
> Link: https://lore.kernel.org/all/9d8c03d742fa9767f30e23d75ddf0baf4296c88e.1714647917.git.jk@codeconstruct.com.au/
> 
> Dawid Glazik (3):
>    ARM: dts: aspeed-g6: move i2c controllers directly into apb node
>    dt-bindings: mfd: syscon: add aspeed,ast2600-i3c-global compatible
>    ARM: dts: aspeed-g6: Add nodes for i3c controllers
> 
>   .../devicetree/bindings/mfd/syscon.yaml       |   2 +
>   arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       | 543 ++++++++++--------
>   2 files changed, 318 insertions(+), 227 deletions(-)
> 
> 
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f

Hi all,

Gentle ping for this series:
https://lore.kernel.org/all/cover.1777058942.git.dawid.glazik@linux.intel.com/#t

I received Reviewed-by from Krzysztof Kozlowski (thank you).
Could I please get feedback/ack from maintainers on the remaining parts,
especially ASPEED DTS?

If preferred, I can respin/rebase the series.

Thanks,
Dawid Glazik

