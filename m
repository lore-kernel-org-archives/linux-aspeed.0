Return-Path: <linux-aspeed+bounces-5180-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E10ACC6B03
	for <linux-aspeed@archiver.kernel.org>; Tue, 13 Oct 2026 06:23:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3kmk4306z3bqh;
	Tue, 13 Oct 2026 17:23:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791872614;
	cv=none; b=CrNY0T7wArYCnFYZomro9R2ZR/vPj8Ux0SP74hns2p1jNjbKz9X/IfIX+2PCaxtVeEOtQnH77k3qpqpcNgEk3gDipYFdC3sHnEzqfeZIjMnfFUdaDZHOd0nV32HdhF92mB/0xCJnQUO684KboQTlI+fZt04+vdx+e1ux2NWkceDqhORVp+YWBm+Pl2H0i+o5YS2IWbzIUJvn3wcjlkQG/ErSi5TAHOgP5dyRqFtjdwudEEfo9+ea97qvJFwEfrkOcexIubXCGRd5BOA1JhBnXkWI4qhHk9nhEQ4gYduJZmiCnCt6ShWa4Z7kgKbyh2b7MGtq8mVi0ZCEJfLFWByVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791872614; c=relaxed/relaxed;
	bh=0HnJGUuH5eNBfEnrm1c2/GsIle+JyJvfslh3ceYOWxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIsncH0/Hb1g9KoD5oOgPVG+MamADXQ6QAhNyx9PTx0hT/MbQSQ9m4YMMj05jpC1nWB2GUCXLW4V5Xcp68VnIvLIp1PaAr24OxjGqjTQaQ5nOl4K1SkjnkKEc/hL91GEGvINNEwvSgTEbplviUtVnQGzDnScvDUkanRKGWRviFA/Z8j9kEsBuB3K7zQqG3hTiy8lnoTV5GAI+kMMuqLMmeY4QGQNYL6bI9gJilepcbka/xq/faHTTHN837vFIgJLe38vw6fms8jqFhLVcSm9xGQccZX+3PqTSRwf54mUAM+6lRuOVgPr+fo+4hwgSVkc3SQeLcSrtZnXiZwoBlNS+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A3pPl7rl; dkim-atps=neutral; spf=pass (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A3pPl7rl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Tue, 13 Oct 2026 17:23:32 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3kmh2FVZz2yLY
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 Oct 2026 17:23:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791872612; x=1823408612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZfsT/JnJx9KNk/XKB+11jQcQueyMxv3z5WgRkl62X7g=;
  b=A3pPl7rlxgAsUxWMSIssdxZ35jf7tZtq4Hkkh1k6ot6cQmm443Wb/d7k
   mrvCFnHwIsa66CRA8jVRWNEGIqqgal4WTUgRfKcW6h6XexiuVH8Gtm29N
   duXLPHAesGn47ZYHVB28eoyq9o4fg73uzz/HwQanbb1A13QdOkxnTZDkN
   Y3ui91jVbnjU/3tXXyFGFqW0PkapPRhx8lDdeJWOAhtZNb78d+WIMGhuQ
   Qu4UGU+Z87g8/DCfnp3glF4kRVVLoyyBOr5QEoK0KIqcTlOrivYberL2L
   h4R49XiBpPpSbNHnrmU6rfN7vHfCcxhaGWt8Lqx7jcWReEM2y3wGMKp5i
   w==;
X-CSE-ConnectionGUID: H82waMRJTk+67st2Nv7Rag==
X-CSE-MsgGUID: vFPGSoMHQyOHrYLcxykuFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="488012"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="488012"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 23:22:23 -0700
X-CSE-ConnectionGUID: WBV46saPQgWfz29cSZhMRA==
X-CSE-MsgGUID: Z44VSfF9SPuWjTtafJMR7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1092067"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 23:22:18 -0700
Date: Tue, 13 Oct 2026 09:22:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Phil Rosenthal <phil@phil.gs>
Cc: "git@gregoirelayet.com" <git@gregoirelayet.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Lee Jones <lee@kernel.org>, Tan Siewert <tan.siewert@9elements.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"mfd@lists.linux.dev" <mfd@lists.linux.dev>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"jacky_chou@aspeedtech.com" <jacky_chou@aspeedtech.com>,
	"yh_chung@aspeedtech.com" <yh_chung@aspeedtech.com>,
	"ninad@linux.ibm.com" <ninad@linux.ibm.com>,
	"anirudhsriniv@gmail.com" <anirudhsriniv@gmail.com>,
	"andy@kernel.org" <andy@kernel.org>
Subject: Re: [PATCH v6 4/6] mfd: aspeed-pci-core: add AST2600 PCIe BMC device
 driver
Message-ID: <as3OF7O5hnImaAWO@ashevche-desk.local>
References: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
 <20260818-aspeed-driver-v6-v6-4-fd7cc0b338ea@9elements.com>
 <C5A01ECE-9A61-4BCA-88C6-83A1673AA69C@phil.gs>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C5A01ECE-9A61-4BCA-88C6-83A1673AA69C@phil.gs>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 03:04:43AM +0000, Phil Rosenthal wrote:

...

> The simplest fix would be to make aspeed,lpc-interrupts required
> together with aspeed,vuart-over-pci in the binding, or to set SIRQ 0
> and 1 for vuart3 and vuart4 in patch 6/6, so the BMC side always
> matches the host's table.
> 
> The more robust option is to find the vectors at probe, which Tan asked
> about in that thread. That works whatever SIRQs the BMC side uses, so a
> board DT that leaves them out or gets them wrong still gets interrupts,
> and if no vector can be found, the ports fall back to polling instead of
> waiting on a vector that never fires. It would also be the basis for
> stock firmware support if that ends up in this series.

I interpret this clearly as "Let's allow vendors to continue making mistakes
and provide wrong DT/configuration bits." My vote is definitely *no* to a such.
If this needs to be done to support some weird firmware in the wild it must:
- be a quirk that is clear sign that one has avoid such an example
- inform the vendor to fix their crap

Did I get it wrong?

> It's the MSI counterpart of what the 8250 core's autoconfig_irq() does for
> legacy ports with UPF_AUTO_IRQ; I described the method in [1], and it's
> aspeed_pci8250_find_irqs() in [2]. With the DT fix above your boards
> don't strictly need it, but I'm happy to send it as a patch for
> aspeed-pci-core if you'd like it.

-- 
With Best Regards,
Andy Shevchenko



