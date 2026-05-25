Return-Path: <linux-aspeed+bounces-4130-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A56CD5BC9
	for <linux-aspeed@archiver.kernel.org>; Tue, 26 May 2026 01:05:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPZLb1BBVz2yR5;
	Tue, 26 May 2026 11:05:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779696248;
	cv=none; b=XQGgrjpgcuysc/SBvRpn8Dj3ZhXeLLwcvbjthDQ90LlFVnKL/MM1cjVS83at2i2HUKh5tboZuHl6hTp6TE+2QA21K371olaYZXPgAugUcYbM8TwS49lTXEdMWsWNAJr9gz5qOcWyTjmHK3gErlEA3PlHlmJwpjZ65zQ6gR7vpFefC9nsx+XIf8WVPEJ3Zh0EJeYSMgMW3fplcZeRy4IIDgV/2DPlQUe7FkzxMna4466c8HFDAy17X28TvZGX4+ZtELNyjUw7tyv+EL8WNNziYJl2qczc4vJpMlizU40kf7TXyw0FLw6MXibpdy2wxCzHM0XZ2p3Fsojy3sWcEkDYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779696248; c=relaxed/relaxed;
	bh=4vllGicUbdN0Bqlbgpv612IvW1fY5Ga0NBXa/j5YjIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDYiWJSQ7m9+WlfH8y4ngEr5MS9eLgTxl3L+DJwwF6vx7iG0x/excwsF3Ytp/OaUq6n1rYn0hkMtbKGc9IKdtUBh2QVkVgK7s4Y3C9pBBflCkjBmHLHrcY26T2QJ5IDbQ2USWrRuMBpOTeOZhLrx+lMlgQ9EQFzr1eYbvSMxey2x4plYm7mPWusJWp+IcRN1HZx6vuM5ZqWwbiGYyCcZAivgsyFwpuoiYKitDQkL5ggCZrc/8PIhKvgXZ0Pa92cxoMdjKxp3YuYW+yv3b9kRcBnjE146cjaMFVKJ189ZqUpOTQBxkKPhjaNplkZ18Z1lwU/vC7KzTjDYS4/1GRYbNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ONAbaRd5; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ONAbaRd5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gP7gq61TJz2xnK
	for <linux-aspeed@lists.ozlabs.org>; Mon, 25 May 2026 18:04:07 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 16BEF601F4
	for <linux-aspeed@lists.ozlabs.org>; Mon, 25 May 2026 08:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E931F00A3A
	for <linux-aspeed@lists.ozlabs.org>; Mon, 25 May 2026 08:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779696244;
	bh=4vllGicUbdN0Bqlbgpv612IvW1fY5Ga0NBXa/j5YjIk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ONAbaRd5hqziXmIjbcC45rSuMKkCRwKMzaE5TnBLMmpKaBNi2XQTIHCByRBlPx94U
	 D0P927r+Dy99NpqkcQvUqZWEaAqOFGFfnEs5lHaRE2WGyJv7xuLufbCsGcJ2oRfLbj
	 gKaHHVcaKTqOAvznP2yIgagbACgHVBeY2UYDElQJ3Mui3JaEOF003cyzcFNZhN+R24
	 T5Ew2lb3JwFp4FZpTOByXSTyVg0JzCkrQsxAkhl8GCCRDUCoExzF/aJgKQaUr3Tx8r
	 dSeLfEcsUr18+bjRAchySs1/M5kmAJ4cKFtzjeP6gVrnaPOxT4VR3tU1zzmn1ztxkG
	 W39EL/s9uPKMw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa21fa024cso6917241e87.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 25 May 2026 01:04:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+BXWRW9ColTWY1Y3R5ZCpVWWn5fj/InkPVD1ZPvIfJBe91BTMZxYCCg/hC2EIVDaVVQRvkv0Rw+7ssA1s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz3Dccg5/nNn5tZPT/6GFM+H8OPk2PAq8WnFfKMoTazRRq114OE
	rLDo3US6JAwlsvMO6DQ4AN26BCgHeudoSd7rH5MbodMTk8KSeA+O851D8zKllru1kTsadIhM5/J
	rEwlbcXyavfKTbDPvnXfQwsONnp7B5VE=
X-Received: by 2002:a05:6512:3ca7:b0:5a8:8825:15fc with SMTP id
 2adb3069b0e04-5aa3238ba06mr4490982e87.3.1779696243482; Mon, 25 May 2026
 01:04:03 -0700 (PDT)
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
References: <20260521-pinctrl-single-bit-v5-0-308be2c160fc@aspeedtech.com> <20260521-pinctrl-single-bit-v5-1-308be2c160fc@aspeedtech.com>
In-Reply-To: <20260521-pinctrl-single-bit-v5-1-308be2c160fc@aspeedtech.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 25 May 2026 10:03:50 +0200
X-Gmail-Original-Message-ID: <CAD++jLm5Jsrdpg=H8xowFzx9omJhGpamjjcg0LYN2R9HCeW5tw@mail.gmail.com>
X-Gm-Features: AVHnY4Lr6P_gJlk6yPcaGrv6903bIHaJS623wqRPa4vQc7mnCclEd4yYEBmZPTc
Message-ID: <CAD++jLm5Jsrdpg=H8xowFzx9omJhGpamjjcg0LYN2R9HCeW5tw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: mfd: aspeed,ast2x00-scu: Support
 AST2700 SoC1 pinctrl
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Bartosz Golaszewski <brgl@kernel.org>, 
	Lee Jones <lee@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>, patrickw3@meta.com, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, BMC-SW@aspeedtech.com, 
	openbmc@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>, linux-clk@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 11:17=E2=80=AFAM Billy Tsai <billy_tsai@aspeedtech.=
com> wrote:

> The AST2700 SoC integrates two interconnected SoC instances, each
> managed by its own System Control Unit (SCU).
>
> Allow the AST2700 SoC1 pin controller to be described as a child
> node of the SCU by extending the compatible strings accepted by
> the SCU binding.
>
> There is no functional change to the SCU binding beyond permitting
> the aspeed,ast2700-soc1-pinctrl compatible string.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Lee can you pick this up at your convenience?

I'll apply patches 2 & 3.

Yours,
Linus Walleij

