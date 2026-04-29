Return-Path: <linux-aspeed+bounces-3974-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77DFFF8867
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Apr 2026 03:46:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g53C23DgBz2ySW;
	Wed, 29 Apr 2026 13:46:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777434414;
	cv=none; b=TXUHwkus1RcmC004FXdf10os+/2S50z+JpPhhYO6f3Z0BvM5dhnnSWkbAWqLdYYXy6jD2UDe6gvL9Go/42cvzVjnlnX4SLjrAT/IK+nOJMHgIRZeY4A2ob2HQL/liN80x+/0BPgDhouoScAps48YjrmIEsG/eibTYCG97Xz5v+IRvClfGdei01tEmPAF1tYLVRAsHEzat+C179TZJfPw2QZKNuVbPwj3B+ztd+C8gXatdlwRzWYaIVCjLzT/bY45X4WFYhP0MdgIVYrboRuM5ToY/zCEXZMUfVTZnbD+cGbbUOvgNfr7uZYFLTy0sSaYi4yhyQidgobUHxRc+5IkaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777434414; c=relaxed/relaxed;
	bh=9PlwOMJb59m0dV5l30jKmO5m42xoUBZhDmyraeHzGwo=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=hKS8j3cqwRatAslvuGEoPpX+0LYdoigUjvAyM+MM5Y6rW9Et8WJ5aPp0pU+gOqw87u+9Ztq3O8XwphDNwV9elE+9g0ZoXKukc16osqfDK9AT2Rn7xFC4zjOOfG5DvKvd6RjtMaeVeUZuJWXs0CYfO1SEhk8qYaHY/RY6aKqDU6++kiJv8uiNbwtzB8GoyA9XZs8yO1eO/+A9SM0irZNy4u8Y1vjCqbdMsb+2CxRAoxGdCvocHhYbvZ5dL9mzgMIDNT4s4RKNWPlGQHNYymE1qX3TANO5YCmSj6ZMEqY+KZFb8qKKBcOQh2PlWRAZZepOm0FpzdiXghAz4FixqCGpFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IAyb8qS/; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IAyb8qS/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g53C12WGvz2xJT;
	Wed, 29 Apr 2026 13:46:53 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BAA7C42CC1;
	Wed, 29 Apr 2026 03:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5E8C2BCB4;
	Wed, 29 Apr 2026 03:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777434409;
	bh=9PlwOMJb59m0dV5l30jKmO5m42xoUBZhDmyraeHzGwo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=IAyb8qS/AcltzaJjzms3GU+9Sg2utIMY2EwiOYtHCTEIXAQKwGUo79vTkt006TVn+
	 xibvJKT3Fk2XMDGPbjWqQWKkEw5UZ31XQyEb8ftkFblhIxTjSyLFJSg9SPPOQh/9uB
	 JC/yB7IoH0GlspeA8j+aAMFjp1lU9aVjh9DzkhoDJmNPD+7z+eXanFJqdVKyRT/98m
	 X0sbbneSAtQRidAbMZeMADH4v/dguO62KJkK7y1BPzaBczGdvgLfxJMCQtbYluspgD
	 wp3gbDSyCay/fnx/CZ8RjHsWPHDWC5xDNq7Gw5VCEwUE6bAT1WkQF7DH6C8TR4Qdls
	 QZmzq0mFTCq4g==
Content-Type: text/plain; charset="utf-8"
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260428-upstream_pinctrl-v8-0-eb8ef9ab0498@aspeedtech.com>
References: <20260428-upstream_pinctrl-v8-0-eb8ef9ab0498@aspeedtech.com>
Subject: Re: [PATCH v8 0/3] pinctrl: aspeed: Add AST2700 SoC0 support
From: Stephen Boyd <sboyd@kernel.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Bartosz Golaszewski <brgl@kernel.org>, Billy Tsai <billy_tsai@aspeedtech.com>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 28 Apr 2026 18:56:20 -0700
Message-ID: <177742778029.5403.7247019083523002317@localhost.localdomain>
User-Agent: alot/0.12

Quoting Billy Tsai (2026-04-28 02:49:44)
> AST2700 is composed of two interconnected SoC instances, each providing
> its own pin control hardware. This series introduces bindings describing
> the AST2700 pinctrl architecture and adds pinctrl driver support for the
> SoC0 instance.
>=20
> The bindings document the AST2700 dual-SoC design and follow common
> pinctrl conventions, while the SoC0 driver implementation builds upon
> the existing ASPEED pinctrl infrastructure.
>=20
> ---

Why is this being Cc'ed to linux-clk? I'm hoping it's a manual typo and
not some sort of misconfiguration in ./scripts/get_maintainer.pl,
please?

