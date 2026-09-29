Return-Path: <linux-aspeed+bounces-5054-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3A9CA5FAB
	for <linux-aspeed@archiver.kernel.org>; Tue, 29 Sep 2026 03:32:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv3dJ03vgz30Vb;
	Tue, 29 Sep 2026 13:32:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f9:3051:3f93::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790652723;
	cv=none; b=f2q0cgyaH/CFHp4gBNL1EEbz81gVe4SRqnw9jaGNX+iZSiQ57/RF+dyazrMmfpT8yST8JOIOfINS1DPttUVgbSSixVGi6SOrS5fpdpZ4+wggQ1uflyVSw0iu4FVnAj/IhHVtH51AgJ1Agu4RTQBfrslAXgo38sOLEw8y9VEqy/VZmcLFp51b9f4BRQH9jHlzXjzpHg/NRHQzS2yd8l1ruzsGuoq/dypQ/Ip8mkVgEm0OJ45DOHvbMmby8Caa7asG+Sxq4PgkBsiQAwhenMiSG+QY5Ooi4oKdENADlTo7Qi+a54Bn1o6wP3pZfWMdVA2kkbM3IuZ+pP5qp+y17RnnZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790652723; c=relaxed/relaxed;
	bh=Al1glvz/IJj4lju1yIZV4opc56skglAbD2Mb6ols/Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA/ZulgTZK7goaJpUt26Z3PfySGqiTkbC5Tb2JarS9NHQe4yUqNgkmJpe24WYR8UE03taOqm4z/qmAzT5+QLTK3gtpm6NeXuGm9NSR1sn4RA7w8/T5LnHEDO0auH4HfYQD4xeK6teJ3fwUXhGcBW2BDKDpDFA73rXZ1r2ip6wxIMwdZmNAxT/Pw2B8PhBuyE39NfWSnGnBofUYFvwcWt3BUauKPUzCNLtKcIp3K3k8IPEh5+S1h9W0z/W4nvdwEo4ceBEk+wPqagG/faMjIz6+zr29tojdxub4du2S3bzMnm1BYHdfTF1dT2xJfGllIkGPRxV0WGKdxQMfKiPFuK2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de; dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=b2xX83qV; dkim-atps=neutral; spf=pass (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org) smtp.mailfrom=alien8.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=b2xX83qV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alien8.de (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv3dD73Vrz30PJ
	for <linux-aspeed@lists.ozlabs.org>; Tue, 29 Sep 2026 13:32:00 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B20B740E015B;
	Tue, 29 Sep 2026 03:31:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AGeAEptx5KvJ; Tue, 29 Sep 2026 03:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1790652700; bh=Al1glvz/IJj4lju1yIZV4opc56skglAbD2Mb6ols/Lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b2xX83qVtrqyb8mS4q5XqI6B7tukE5G9Ex9svkbCNsvYQM1STItgNJZLhFH7jOprf
	 ZnqnWsAjGzvXa4ki+Ce8YhW25fxIk4zZP2MPu1m5uewrjzU6AgIY+YDt/hlX5A/WnS
	 wbNbX+EoHTWQ57uwS5dGF6frcpjZnoL0AE4nFXPdx8rIzQS6huorHx9QDgADcTu6np
	 BvX8XqqYx7r4h7hY6KqCbHuOVsdpcC3WdaaoYkl/EaeQ5mBFoP5HX1541VuIF7BN++
	 +ftjgZxmLw6V65pAWX6aM8i/A24gXBPDWi0sELtxxwdDtuq5vdkpbSXpHa+s0PTfCy
	 bMamNYiYhF4Fc3QBie1uJfojYAbTH1ij0mfqFcLiDfKSbOXnr1Beq/YZiyiYaMIVCy
	 c1ygwBZFNoQARMOYc/U5L7kfjr7H69AisDYf/erqcbyINHQjmuZKNfcZzykI6w3Fz9
	 AB3JN+Bqdtz6AOlE0Kg+4hQxJYRfXcY1nCFL38zGXtwU6l16iyFsaKV56NAt5/pM2R
	 jNueI4+E7Fdc9DKceSw2zwHEaCaNKysybe4tMHcYZyFbXrOGueSE3nkB1FCNmjUuq8
	 N5Eff6NarqWMZvBBgInzKSvjdKwBfoZ9+edWyzJuq3kWDFSrW4gIYNwFxuyg+ow3XY
	 zppgwRQH2s14Ti8O00DZC6so=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0679240E015D;
	Tue, 29 Sep 2026 03:31:23 +0000 (UTC)
Date: Mon, 28 Sep 2026 20:31:21 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Tony Luck <tony.luck@intel.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	Borislav Petkov <bp@suse.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3 0/9] Add Aspeed AST2700 SDRAM EDAC support
Message-ID: <20260929033121.GDarsxCR4uIpLB69P0@fat_crate.local>
References: <20260916-edac-v3-0-23e9ed2fbdf9@aspeedtech.com>
 <20260925054444.GCarYKTAdrrJ5a2VYO@fat_crate.local>
 <TY2PPF5CB9A1BE6EE1ABEB80D36C3365473F28C2@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TY2PPF5CB9A1BE6EE1ABEB80D36C3365473F28C2@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>

On Tue, Sep 29, 2026 at 03:26:42AM +0000, Ryan Chen wrote:
> > Subject: Re: [PATCH v3 0/9] Add Aspeed AST2700 SDRAM EDAC support
> > 
> > On Wed, Sep 16, 2026 at 01:30:37PM +0800, Ryan Chen wrote:
> > > Add ECC error reporting for the Aspeed AST2700 SoC to the existing
> > > aspeed_edac driver.
> > >
> > > The AST2700 memory controller keeps the same overall EDAC programming
> > > model as the earlier Aspeed BMC SoCs, but uses a different register
> > > layout, a split interrupt status/clear/mask scheme and DDR4/DDR5 memory.
> > > Rather than fork the driver, the existing code is first tidied and
> > > generalised, then the AST2700 is added as one more per-SoC variant.
> > >
> > > Patches 2-5 are bug fixes and cleanups to the existing driver.
> > 
> > You always put the bug fixes first in a set. So it should be 1-4 bugfixes, rest new
> > features.
> > 
> > --
> Thanks your review.

Not done yet but you can send a new version if you feel like it. For it, you
could also pick up Stefan's patch and merge it with your last one so that the
driver doesn't become orphan.

Also, think hard before you mark fixes as CC:stable because stable fixes
trigger a lot of work downstream: stable trees, distros etc. So consult:

Documentation/process/stable-kernel-rules.rst

before you do.

HTH and Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

