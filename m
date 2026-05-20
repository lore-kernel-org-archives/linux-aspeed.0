Return-Path: <linux-aspeed+bounces-4108-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F1ECD4F3D
	for <linux-aspeed@archiver.kernel.org>; Wed, 20 May 2026 14:43:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLDn50qkbz2xrC;
	Thu, 21 May 2026 00:43:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779288216;
	cv=none; b=B16SGnqmjcf5/AETq0k/9CuBG9STz03BAqbP4f3c3xpGczIplWkdza6Xcad03ssmhj8K/yarMAExXxzmHY1HV94vUrJmIM+wO4zx5w9BswKwU48qtCVLlLYBlqE5ni3P18Kj2D/seJ/Qg0PQ+Bkxf7NU1BmUnM2T2/LdiIqmQfL9OzKOVi0LjNnRaKwkvezs5+JPlEEVDPIQ2Y53IOmLa2wi/y2dwlF77q2VzlnqX3FL6yY/8CezMhSbkQt/zePCqWre/ZJSmefTnPWIR9gTS+4ro922fM/+qF2T14YQZGUcPTO3uNz/Kb4Hhl8Rji4zzU5tcTDUR67CfiFXJsGGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779288216; c=relaxed/relaxed;
	bh=dQbuftW1Dswfh8UjRtvt8jMWgNKtgGpobxc7mm/y8M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4vbZicch4ZaVJxcowY6Md37IzHeAQWMZyDWwJHZ2appb/I0GZeoJWc+7eBiJ3Ax7a/LxEIQNC8OIXTeRXhKii4aXxHc/Uw0MJFAo/xHRXTIDtJld5IMhokexE/n4Esco8nBhkcAEtkiV2Krp+Bb8LaZQ+W2pyos6HkUklg+59aKbwO3mzBf+DZtH26p8TQPJNDKRJmWp2n+XA4SxfzAc7EnNGAhrrHtLrcbdKtMhP/Z5YDrcj9io7dc9TVTxYMvXhzqrxAIGD4ecLTqhhWTigWjQOCM70pH8lZX5wmt5iHfNa2RB2jXS8/Wz268cEq3RRPouDTYtIC3IyshUf8moA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MEYFAo/s; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MEYFAo/s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLDn40WFFz2xqn;
	Thu, 21 May 2026 00:43:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0EF0F40DCC;
	Wed, 20 May 2026 14:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DE61F00893;
	Wed, 20 May 2026 14:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779288212;
	bh=dQbuftW1Dswfh8UjRtvt8jMWgNKtgGpobxc7mm/y8M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MEYFAo/sifgemFgE3i2c/qG0t36EfY4Vm8VA6haQyEKuAPOKWhwYAvREwF30EcIJ+
	 idMTk38KIuZ7UmRhX+7E4W94DWidnrTjobRmZVjvFtR739eHNPepO0YSa3z7LTCIEs
	 EYg5JEAqiduiOsJ//BLw58uKmr7rOk8ELb4QbsnM3nYDfcdEdnORaid5pl2iBg9uVV
	 vFp1JA07vMb2hpQgqfHIUjpq3C3CZrKTF1zPE0sHjuyaTi9fDOZ/cKT6Aj1lVk37OR
	 Rs8BoDIFlxaSenFjEnsmQcofS8cRMab87wKT/ix8M5OmV/RX4u8tLOeDk/okJc+6C4
	 xuRPeJx8L88/g==
Date: Wed, 20 May 2026 15:43:26 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v9 2/3] dt-bindings: mfd: aspeed,ast2x00-scu: Describe
 AST2700 SCU0
Message-ID: <20260520144326.GE2767592@google.com>
References: <20260506-upstream_pinctrl-v9-0-0636e22343ad@aspeedtech.com>
 <20260506-upstream_pinctrl-v9-2-0636e22343ad@aspeedtech.com>
 <CAD++jL=3p9BvDgaot3=emM4Zn5jU-ZAUKtB4UwT1HzDiyzKq4Q@mail.gmail.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jL=3p9BvDgaot3=emM4Zn5jU-ZAUKtB4UwT1HzDiyzKq4Q@mail.gmail.com>

On Mon, 11 May 2026, Linus Walleij wrote:

> On Wed, May 6, 2026 at 10:07 AM Billy Tsai <billy_tsai@aspeedtech.com> wrote:
> 
> > AST2700 consists of two interconnected SoC instances, each with its own
> > System Control Unit (SCU). The SCU0 provides pin control, interrupt
> > controllers, clocks, resets, and address-space mappings for the
> > Secondary and Tertiary Service Processors (SSP and TSP).
> >
> > Describe the SSP/TSP address mappings using the standard
> > memory-region and memory-region-names properties.
> >
> > Disallow legacy child nodes that are not present on AST2700, including
> > p2a-control and smp-memram. The latter is unnecessary as software can
> > access the scratch registers via the SCU syscon.
> >
> > Also allow the AST2700 SoC0 pin controller to be described as a child
> > node of the SCU0, and add an example illustrating the SCU0 layout,
> > including reserved-memory, interrupt controllers, and pinctrl.
> >
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> 
> This is an MFD patch in the middle of a pinctrl series, I think Lee
> should apply this.
> FWIW:
> Acked-by: Linus Walleij <linusw@kernel.org>

Already applied v8.

-- 
Lee Jones

