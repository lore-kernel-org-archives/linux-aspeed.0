Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720D0606A31C
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Nov 2026 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MRHnUc3W
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTwHG4Dfnz2xlY;
	Wed, 18 Nov 2026 19:48:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794991706;
	cv=none; b=abntjdlaRibYpM2CYNSspY2Akax6dDOjLCw6ZzsUZ/J5Pu8CetQYfDnBV17OMmPqRS0U3yMOSKQHsAryXunZjwyLI0XBJgmY4vGj21YE7S5Qu/Hy7N3GRA43HNJtcljN/lMdR9MD8beaA6CQYCHKZgEBeppjUhenl1wbBADe+f0Y73OZ7Bo8W+X/chP3AxGHKW9VFR4vWamcM/yZY3flRBTgvzFlcS9mMMv6B06CuCb2+T5SLHcMu/8cfEkK4tgtEIB9o09794aErUc4jnHLRtkt27EABa2r2e4gux6hc9s/TRgIRgnnt8UmMKWKXyU2ckV5vXXEQ9rbD6EzEHSjfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794991706; c=relaxed/relaxed;
	bh=vJGcGSSjcKVHc6b8pVWGQNzThgXfLhxChnkSyknWbOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzLw8HE+PsjIsUarJJv4cMrBYbPQHULxGW+Z/8fJsRj6oKjcN8Q0lUz7rtGTpkmyXPJ51nABU11BCxl+asOFEjCR8FDWUvYqRfDeuGFPQC0S7Id2aolksZ70Ru1lyA3gyQzylS98kiq47jjCdtO5psIgU/ZxMHB8M8zZ5cJT5ni48eXqQI32fyc+MOxlFl+SgvwVh8mgKBcJl6PuXaLGYG3AuKW1/KVMCt4sL91Bwaq1cOewsqehwczKbACKNJ7iX/qJAq9o9QQqLL4m1c6PtgoVj+qqrZjN6gVGAK/rJ4mLr5H3ibjnkJhWjvteNzUIlsKz/+tCdyDEfGceQwfN6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MRHnUc3W; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MRHnUc3W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTwHC4H5kz2xL4;
	Wed, 18 Nov 2026 19:48:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794991705; x=1826527705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=69uAnuF7duZcZRgShYJQb+omDDGQbvMHTSaXAjeuHeM=;
  b=MRHnUc3WC3jd7uHmDsAtODwHVtsiBJa//R8F0V48MCqCpDKZ72nhMfWt
   ZFlihTpvtrfkgn8E+wgZu+wUQwROeq7hgan9+BBpj+UMwXFyb9/zuSmT6
   Kfp/Dm5UP3ZGPojFqVkMMw4sbmV0eB/pfejFQrLj4xxOKk9EzxnwgNXDI
   YZjUL0ymbWNdYIDoUtlSDEigeGFKI5hGeBZikCSgHHyWJKIn4elHh6J9T
   xQ9s7/GL5trjDj7yR09HtbZm487rwKEfyNLF/uSTi1IJiZRvSofW+n64b
   eEVlxN2I06h9pqnE5D+j3LBFgYHi2U9Hd1Pg85nB7AjqJJk7RoGfL3aOZ
   A==;
X-CSE-ConnectionGUID: 499Vu5TQTA2d9oQewjI1cQ==
X-CSE-MsgGUID: nRPEbZyDTu60ZP1Y5fGQGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3816795"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3816795"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 00:48:19 -0800
X-CSE-ConnectionGUID: 7OikgetmSnmgLK4gxGWkzg==
X-CSE-MsgGUID: wD5IT/7YQQWIqN7+H0Q0Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10097320"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 00:48:14 -0800
Date: Wed, 18 Nov 2026 10:48:12 +0200
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: "jk@codeconstruct.com.au" <jk@codeconstruct.com.au>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v33 0/5] Add ASPEED AST2600 I2C controller driver
Message-ID: <av1mTEtWCf8zFbjp@ashevche-desk.local>
References: <20260623-upstream_i2c-v33-0-6d5338fc56ed@aspeedtech.com>
 <TYZPR06MB79202A00572E81CBC29399F4F27A2@TYZPR06MB7920.apcprd06.prod.outlook.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYZPR06MB79202A00572E81CBC29399F4F27A2@TYZPR06MB7920.apcprd06.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 08:14:51AM +0000, Ryan Chen wrote:
> Hi Andy,
> 
> This patch series has been stable in our testing on AST2600 hardware,
> and we have also received positive feedback from customer testing.
> The issues identified by Sashiko have also been addressed.
> I plan to rebase the series onto the latest upstream kernel and submit v34.
> Before doing so, I would appreciate your feedback on whether there are any
> remaining concerns or blockers that we should address.
> 
> If there are no outstanding issues, I hope the series can be considered for
> merging after the next review.
> 
> Thanks for your time and support.

Are you asking me or Andi Shyti?
If it was to me, I have no time for this right now, sorry.

> > Subject: [PATCH v33 0/5] Add ASPEED AST2600 I2C controller driver
> > 
> > This series adds support for the AST2600 I2C controller “new register set”
> > implementation.
> > 
> > The AST2600 I2C controller introduces a revised register layout which
> > separates controller and target functionality into distinct register blocks, and
> > extends clock divider configuration and packet-based transfer support
> > compared to the legacy mixed register layout used on earlier ASPEED SoCs.
> > 
> > The current driver implementation for the AST2600 I2C peripheral is through
> > the hardware's "compatibility mode", which exposes a register set that
> > matches the previous generation hardware (AST2500 and earlier).
> > 
> > Instead, add a driver that works in new-register-set mode, to allow the new
> > features, and will provide support for future hardware that will not implement
> > compatibility mode.
> > 
> > In order to support the new mode, we need a DT binding change to reflect the
> > reference to the global register set. Since the binding still represents the same
> > (AST2600 SoC) physical hardware, we continue to use the existing compatible
> > string of "aspeed,ast2600-i2c-bus".
> > 
> > However: since we're changing semantics for an existing binding, we allow
> > backwards compatibility by selecting on presence/absence of the newly-added
> > properties, and fall back to the old driver (ie., in compatibility mode) when we
> > detect a DT using the old binding spec.
> > 
> > Specifically:
> > 
> > - ast2600-i2c-bus nodes that provide the `aspeed,global-regs` property
> >   (present in the new binding and absent in the legacy binding) will be
> >   successfully probed by the new driver
> > 
> > - ast2600-i2c-bus nodes without `aspeed,global-regs` continue to use the
> >   existing driver (in legacy register mode), ensuring that platforms
> >   with the current DTBs remain functional

-- 
With Best Regards,
Andy Shevchenko



