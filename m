Return-Path: <linux-aspeed+bounces-2957-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B61CF34A1
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Nov 2025 13:52:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dBNFj1LB8z3dHL;
	Thu, 20 Nov 2025 00:52:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::134"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763560329;
	cv=none; b=c75XoG2ijJO4PR7glSF++zLaMfFVQv3lDJHjFKsoInsOPaZTBJtsofg+KQJ+nsy2IMSjUjPlAPaMjLiEbpBU8HoJmL2icmrDzAnkJqhk8OGabHA2ydk6yigUgr+HxYge6X2HwUTOHt8GerHJl8UhQi8XUsztY64Kijn3BzJfi9BPa5ld5cDi5oMDELEB9VbUsYYbEN8LGS2PTEljvHczSTbU0I1S/vzdvFe/GYKZo+e55MesU2mI96stIZg7P+VcSDBth9i5XdXbI495LmMMXLJs4UoQs1r+VLg8fm79cGbu1OXXDduQMU7SruBiOy7cOuIoOuCTCcKryztJiXAyIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763560329; c=relaxed/relaxed;
	bh=9Sw7qNK2MuqEfcGlDiodQEmkMQSxPXI8ojkn2672gPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9XR7Pvmslyd98YpW+2ymDU58AvE5TY4aIEEQr5POYRn11y4r6QGZlKr7jB9IzT8lA/ZwBQtv9QNhieTLTMy6vtNHrA7F5SLGiLBvACu5urm/QGkB0D+yzOeWkZHDsbIde91/x+pu+0uPkrqZoBo0uaYjItsWqz4O0LuaqHw61lYcFUNid48RKsWomme9CQnVpNsKCVeNpVONJB5gV0gppz46vBUM20ZVRQDaxeaV9GjIpdIpmEzChOzHQSUyS2lyQ77bU37xfYU9ZaW4gAR4WvkCY2cNcU/H6nadShZtDZCc0O7R1EvlY4GjqdAHsJVjOb7oAik5iynOpiv+DEk5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZDJxyv5F; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::134; helo=mail-lf1-x134.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZDJxyv5F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::134; helo=mail-lf1-x134.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dBNFg64Xqz3dBl
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Nov 2025 00:52:07 +1100 (AEDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-591c9934e0cso9173803e87.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Nov 2025 05:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763560323; x=1764165123; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Sw7qNK2MuqEfcGlDiodQEmkMQSxPXI8ojkn2672gPY=;
        b=ZDJxyv5FyidRISUWXr5rwBZA9TctLspoECZx3ERNnvAUYL++iXSKoXExzvZUjoc7V3
         qnqa9WMc/4BBYG1rNfxe5Vd/RQ+MTe0ZYCI9FDBMxV6BEUCNBjUKlfKMsLMF8ppVrxMv
         nyN0XA0elu7nNSl9r/v5koaY5m58q845DX4b9kFBCNosRweE1G1B85LyEkBkKA4MnNvc
         79j0O1I0Xv9/LnwAHhhBXc/SKE+9vgmjtq9QaglIV0DMMDVsEC+BpoDgPYa6bOfc/cYw
         OhQX/FQSWSwg+4UTv6kZVzXcjzEDM7Ph0PxSAAeKwaASfnZVcgJnxMjo6YV+toJIddXB
         OyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763560323; x=1764165123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Sw7qNK2MuqEfcGlDiodQEmkMQSxPXI8ojkn2672gPY=;
        b=tW/Lde7neekPGr2OIszYP7causzA1Jo8wJDlm6LYym8bweG/OuncqsAIvMce3pF90g
         IeRk7jGFcDDH1QgbqmCnmmaXOStRCD849QkZHK954JUAFB/niNluVczVrbQu+F3tFM4V
         7f8Dkj1vm9HKTznFfQqgKKfIAIrov0T28Lsqbj3W+XKn+X0k0G3PWNm5BgpAuendgOW0
         5K1gdWSSYGzhHYLQy/qRK+/69HvQUBR1B+/Kyp/Mfd6T32NVZJDB6O6sx03dgxfU8tUH
         3+9SMbwULu8uYY3guX+xhYvcqmM8sn7iSKIcOflPVzv/qrD/kn1ZzsIikvRMVMVeJwhY
         yu9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWo4zpsBeHvDi1FC3wZuUmopRMaRd86OUMstLdbQAvHv5Brf01Z6BAG9zYlmLgwdAJNFAzw13kkoax/aBQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwLOzih76kCbB0GAzfOQIudScwoz6TIzxm5ipXErrQhTGuTZzO8
	u1+vYSqWm9kIMN7a3jnqsPKaMY5p3LlLfPzpYv03wZ6tFu4Puv9e622lnY0ooMjxqCZuJXcE8Tj
	XtS7QeLf4vqZk0ddmloa8H3bxDncNxp1urfRM6a+2Ng==
X-Gm-Gg: ASbGncuguRU7JGJvNDuyoL3vmfh5zQJTnnmmutMl6J4aa5lTDmIUFVy4oO+u9eRvhFa
	lfRNcdgXdEsMA1mDnAax6DJA7IW8vn9lot4RUaOaOXJ5EjleWhE6d1bil4LocpPWABAYa7TRyJc
	hs4pKatW5DAsR8BtwL/Z2qNI/dy7rMDgGzlsxUWZ2nfcrm/sxxhIEjOeUbFkqbsZiTRFy03IFfx
	0V0ZLkqEDD3Gs+8hyo9EPgwsqsv6mj+mlltU7WeO/XuozKk3PV7ZS1ci0uHi21vQ5bnbXo=
X-Google-Smtp-Source: AGHT+IEmqj3lGDApr9edrXMaFwN0H3cZ82GlBpdq67AUQg80YKIMgCzJi1RzhM8yWFVqY0UQAGJbUbSB8ccCc0F5BHI=
X-Received: by 2002:a05:6512:3b9c:b0:578:f613:ed9c with SMTP id
 2adb3069b0e04-59584201168mr7597957e87.43.1763560322586; Wed, 19 Nov 2025
 05:52:02 -0800 (PST)
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
References: <20251117-upstream_pcie_rc-v5-0-b4a198576acf@aspeedtech.com> <20251117-upstream_pcie_rc-v5-3-b4a198576acf@aspeedtech.com>
In-Reply-To: <20251117-upstream_pcie_rc-v5-3-b4a198576acf@aspeedtech.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 19 Nov 2025 14:51:51 +0100
X-Gm-Features: AWmQ_blwvWUHZn6LSm0qwvTRD5Kr7vftxNarMVR6ZM3aN6PFLC6U4mHy-OgOWik
Message-ID: <CACRpkdYp4NuxDA7QLnqQ_pfd7sFZuDjCuZQ8Jim3BYXN=u=2Xw@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] dt-bindings: pinctrl: aspeed,ast2600-pinctrl: Add
 PCIe RC PERST# group
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-aspeed@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 1:38=E2=80=AFPM Jacky Chou <jacky_chou@aspeedtech.c=
om> wrote:

> Add PCIe PERST# group to support for PCIe RC.
>
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

This patch 3/5 applied to the pinctrl tree.

Yours,
Linus Walleij

