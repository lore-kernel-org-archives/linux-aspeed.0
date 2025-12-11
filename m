Return-Path: <linux-aspeed+bounces-3090-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D29D41C23
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Dec 2025 11:33:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dRr7Z450mz2yFg;
	Thu, 11 Dec 2025 22:33:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765452810;
	cv=none; b=mMBzByv3EszCluFAHVf6jol9/rGeu+uaTPZS7h83/j12nukmY0PIl16IaUXqiBuV1kXgfxl1g4ztOEXFi44Xu7FVuGRJ4U6+VxHxM1IQw2E+AJfFnHhr9S4acCx8cSzvBXFOyzJJlUk6m/Mn5IoCm8VkzUmiMsSeGSJW5oIDQmBA4Q62WG0WDxcZoe+Fld8Ew32r+kH1nse/MXXFHtzXqnC80Z9aWLbM6x3JXCKvaXTNNdjPICoNIj1QNp3BIJaH1DDStQBHb7d9SCfIhNnpvjj6FiIqVpVDOjMJEoAbEV41XbJ7Twns0Pi55FtRz8J6fw6SuDFeqp/BTNvjq/lo1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765452810; c=relaxed/relaxed;
	bh=tsAQFyywzgQt8hTuOma0wGcWOIPVIjI9LIgrRTCikK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMWLqE8g6JpwqW8IpeVUKgGO6uYtHyWl38x0xkrmjCPAj5ASEtJ4kbxjUq+WBf0M1SyUTWLOmNnH5sMk2O4DOsnwV7j/zzRb10m7g28JIWWocdM8F8rTMGT6A5Mo1Eumi5KNXhPKuXUHoan57BQciKfkHFOY6wI7pdOcfpwEGp4zjCOgo5AIYaWpEMuHE4gk5LsCHLp8+vgafSMRRiTWrOvBvvdBQ2Bwctd8uTZMYtOJOvvvfnYmduOMsRqerA31n18JK2KVTjhcd7nvVODUjd9nq8I8tMjBIXHQjYElZKZT5NE4LkLr69os7W2REPWyX7eK8y4qsmnHauSAI2UKzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HfOKV2yU; dkim-atps=neutral; spf=pass (client-ip=209.85.128.169; helo=mail-yw1-f169.google.com; envelope-from=ulf.hansson@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HfOKV2yU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=209.85.128.169; helo=mail-yw1-f169.google.com; envelope-from=ulf.hansson@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dRr7Y6Vhyz2yFY
	for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Dec 2025 22:33:29 +1100 (AEDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78ab039ddb4so8520897b3.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Dec 2025 03:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765452747; x=1766057547; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tsAQFyywzgQt8hTuOma0wGcWOIPVIjI9LIgrRTCikK4=;
        b=HfOKV2yUpaYhlWtqBMl/wAYMyoZRx/F1/azn8aEquyefckTJFplT6frkvFjZRDHKSK
         MgzpCuRRYKvv25UGoetFxBZoZiRouIv6AplnuFoi/SU2kPDbl6VCshs2clffppkXiVCe
         fbEmWDsRlsjUATBIacUOH1Emhk7Gry0yulCTDgZNLIelh9tF+6g0wR8muXTXLwcR2FyX
         3fUqqEkTwZlbqYrN2ItSyeCC03Su6RyH0JQi1wlkS5EAXd0Fx2rdhum+bkUw0VQyjEPO
         MI/6me8WWodj13ppbKKiMhtMIlU6iTwY/oa4uhIHMsuqMd/rXtKc4hi5qhKzJp3GL2db
         sHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765452747; x=1766057547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsAQFyywzgQt8hTuOma0wGcWOIPVIjI9LIgrRTCikK4=;
        b=ck2d1ORofvgeJRUpUNGTOIubAJ5wDhssTzxowLCaOylB9Vn4DzyGwMBI60brPNB7B5
         i43FsMvQaiMPdEZRtC+K0F0/IRuesnQQeCoG7LoNt9nn06oSePhrLn/k1+qDd9u/OEOm
         ULxCZvo7p3qFvGjvzhFhgZoang+eaf63n5cCAxJbUMp8pom+8URpC/9q4NQukWFtuK42
         FwEMXFPBlgPGSXK/5oyh+CdX8kHR2zD4E7wc26f4QrsJwet9GBmkVWw9sWYdMgFmCPa2
         ArYZ2DAhwtiFtQ3xilwoURxT5P2DFu5FBB70pH3z4TKWzLrVGKxXapgGkNNSYI4gK7Wc
         XCXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcXWyBoEmCXIusc+qDPP6v8y24STWppsk57XWUnhjlBoHCOcznr0OVanA/8n3mQ0N4rTpYYL8dc5kOQ7U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwvbhJcwH7XhkUNyX9WsbPn/GCxckcj61NrToh4OYKH5cDiWUZc
	xbw8Aw5juTVS/Epgbekr0+ddsiUYVNKZ3ZKlpGsRI/H5KQbu9mnaOAWGyq0HEkG+5u397tBSCbb
	pcER9D7qQtBI9h9xvS/vws13v4XbUK2QRtJJFRCW4Yw==
X-Gm-Gg: AY/fxX69ir0dKNbQ0VNOVtwR0aDWz5wAK0ogiUIXoVGxEwAX+KdnlHV9zN6fqOyTirz
	cuUDtPL9uxRtnkYLqlbIfdnnaVPH0oDRqdVR9NmR92OvxA+r8N763rA5LMVdYpzKDS+Bij8zIJI
	WbjHJ+0aKPqvMshv7xVGEnSh7kSiTh30+ShwdwMH2m/kGVosUp1KeEx17yd3A4JDf19ZxiW5ci4
	zt1J40t7iKZOEDoFHjXvdWldElAMseCcLDdrMdEngKOTgaIchZFgcvqMkbrJAKUvr7JNBhTuCBW
	1BkflNQ=
X-Google-Smtp-Source: AGHT+IGi8FI7tue2F1muYiYdXCcwa1VCSq2fLFaLgh7A0p4DE+EvhP5UsxEj9lkt3uuk+LvjC2KVDNW0gmzNrvJK74w=
X-Received: by 2002:a05:690c:45c5:b0:787:bf16:d489 with SMTP id
 00721157ae682-78ca64495eamr51688117b3.62.1765452747098; Thu, 11 Dec 2025
 03:32:27 -0800 (PST)
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
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
 <20251211-dev-dt-warnings-all-v1-8-21b18b9ada77@codeconstruct.com.au>
In-Reply-To: <20251211-dev-dt-warnings-all-v1-8-21b18b9ada77@codeconstruct.com.au>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Dec 2025 12:31:50 +0100
X-Gm-Features: AQt7F2pk6E2fyrBRST0HoIuBOhvmNQUfLJiP182o7R-P0Ig55Fk3IUyQwfYuHbU
Message-ID: <CAPDyKFpQXYFFrZ-unVxa9m2+tKLEyFZyo7Tv7JD_7vTbqqfmDQ@mail.gmail.com>
Subject: Re: [PATCH RFC 08/16] ARM: dts: aspeed: Use specified wp-inverted
 property for AST2600 EVB
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Dec 2025 at 09:47, Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> While sdhci-pltfm supports sdhci,wp-inverted, it also supports
> the un-prefixed and specified wp-inverted property. Switch the EVB
> devicetree to use the specified property to remove warnings when
> checking the DTB.
>
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>

FWIW:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>


> ---
>  arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> index 3eba676e57f1..c51977dcb56b 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> @@ -315,7 +315,7 @@ &sdhci0 {
>         bus-width = <4>;
>         max-frequency = <100000000>;
>         sdhci-caps-mask = <0x7 0x0>;
> -       sdhci,wp-inverted;
> +       wp-inverted;
>         vmmc-supply = <&vcc_sdhci0>;
>         vqmmc-supply = <&vccq_sdhci0>;
>         clk-phase-sd-hs = <7>, <200>;
> @@ -326,7 +326,7 @@ &sdhci1 {
>         bus-width = <4>;
>         max-frequency = <100000000>;
>         sdhci-caps-mask = <0x7 0x0>;
> -       sdhci,wp-inverted;
> +       wp-inverted;
>         vmmc-supply = <&vcc_sdhci1>;
>         vqmmc-supply = <&vccq_sdhci1>;
>         clk-phase-sd-hs = <7>, <200>;
>
> --
> 2.47.3
>
>

