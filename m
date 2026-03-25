Return-Path: <linux-aspeed+bounces-3769-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40852109C045
	for <linux-aspeed@archiver.kernel.org>; Wed, 25 Mar 2026 16:52:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgtHn64Crz2xmX;
	Thu, 26 Mar 2026 03:52:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774457557;
	cv=none; b=Bc/O7KWZdB1y60iTb6L9nIT0wwazwzVUY3+bltk+M7ICD5wQaIHlwU0zFk+259hFAJfuAaBk2sA8Va81EQ/4zlxJdxaH3av0zc/i9eyzgNsxX3471pVQO/KYDARYa4/2Pr2wvj9FAdGNCLlhQU6/k8uEZGUEpAW7d2VizaRQ7ZGpw3JWC01x1F/D6oPz7czbvO1vOTce2YXsc5a0le1ULJhAil4dMl3jIqAdN3dBA2+m+22mTvTU5yMLJVkGV+tFR2Epwa1SnPQugHp3p0+DEH1qdMP2sFyByfvPZ5pmB3ZzE87eOal/PqrtGzMy9Ft369FQNZQe3Q1j/1UR+FiNkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774457557; c=relaxed/relaxed;
	bh=aX6Zt92Rl7zamMR40yxS1SAo7vg/tk+fp4b2fvllx30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzyKYL56Sv55N1LUD7mdZJbBeKWBzZ+QOiHW13J5K7fE8/547/cdpAxlnj8+Gkf6P8ztPxBwBdGU5Spn2OBIe5WOJQiHpPwxyJbhBkCCgVoXbgNgDBYIUwzZ3Uxq7K5ctUjzruQBgSyrs6mMhH6nGQI9AU1NiuOiB8Q/YGRcqvzCatdSIqiAWQ8jZXM+M/6TLnAoyymeeXR1ef/19FlX9KPWDYOI8XzykScegI5ebxxei5kPgQfnFqUbWZ0TEzmN+FynnKl9t+LX7nrS5m5RDqK0xgKd+mNX0wTudtOrOvuRHURsawovqIh78K3Jd0TTQO0112GXImdFVKcL/srKTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eANHokos; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=eANHokos;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgtHm6Kfcz2xlf;
	Thu, 26 Mar 2026 03:52:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5C16744557;
	Wed, 25 Mar 2026 16:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F026DC4CEF7;
	Wed, 25 Mar 2026 16:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774457554;
	bh=pWOqtv6jmpKLYd9pPWq7muuvSWKqfEOPOAHMJ6IkXEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eANHokosIVd5KD95xp+HQHRfvXeuEHK7Eo6rbRCk32CsXyhlZFVFE2ezxytgD44zU
	 ZjYbNSKo/8j6WtbSSI3hYpj9HcFPD5hrfB/Y9thx8togWdftQf8QN2swMcN+5jdHWl
	 PZiiqM95vlHF3pO+VaVFD2HUUvhksmVKV1AcKQsFftLkZ8RvQQ2FO5ikayoqBf+3OG
	 /LkA3oXJTWAM4YYUJLWe3nCCg7XqPkqfD4nBpNDjw/lV08H7YZHYkgLYtdg3MHBic4
	 OqG/BVzr/uCUsDzNpOUrXND7FnQuVkffbmLkBWeDf/5GhrdHVuwN1gWHBoM4kvKgZE
	 J2shInOqyYJsw==
Date: Wed, 25 Mar 2026 11:52:33 -0500
From: Rob Herring <robh@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rayn Chen <rayn_chen@aspeedtech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v27 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
Message-ID: <20260325165233.GA3782899-robh@kernel.org>
References: <20260324-upstream_i2c-v27-0-f19b511c8c28@aspeedtech.com>
 <20260324-upstream_i2c-v27-2-f19b511c8c28@aspeedtech.com>
 <405f6b1b4081ffb379a21bcdb5d2a8e81d2e2e3e.camel@codeconstruct.com.au>
 <TY2PPF5CB9A1BE6F0B9087048F46ABD72A6F249A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY2PPF5CB9A1BE6F0B9087048F46ABD72A6F249A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>

On Wed, Mar 25, 2026 at 08:11:54AM +0000, Ryan Chen wrote:
> Hello Jeremy,
> 	Thanks the review.
> 
> > Subject: Re: [PATCH v27 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add global-regs
> > and transfer-mode properties
> > 
> > Hi Ryan,
> > 
> > > The AST2600 I2C controller supports three transfer modes (byte,
> > > buffer, DMA). Add "aspeed,transfer-mode" so DT can select the
> > > preferred transfer method per controller instance.
> > 
> > This patch does not add an aspeed,transfer-mode property.
> Will update use aspeed,enable-dma

[...]

> > > +  aspeed,enable-dma:
> > > +    type: boolean
> > > +    description: |
> > > +      I2C bus enable dma mode transfer.
> > > +
> > > +      ASPEED ast2600 platform equipped with 16 I2C controllers that
> > > +share a
> > > +      single DMA engine. DTS files can specify the data transfer mode
> > > +to/from
> > > +      the device, either DMA or programmed I/O.
> > 
> > As we had discussed: this does not define the transfer mode, only whether
> > DMA is available to the peripheral.
> > 
> > Why mention the 16 i2c controllers here?
> > 
> > Please keep this description simple and relevant to the specific purpose of the
> > property.
> 
> Will update with following.
> description: Enable DMA for transfers on this I2C bus.

You still don't understand the distinction. It's not enable, but that 
the h/w instance *has* DMA capability or not. It is still up to the OS 
what to do with that information.

Rob

