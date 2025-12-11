Return-Path: <linux-aspeed+bounces-3089-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF8BD41C1F
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Dec 2025 11:33:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dRr7T124Jz2y8c;
	Thu, 11 Dec 2025 22:33:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.224.49
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765452805;
	cv=none; b=kDxV8KFAjBQ10uwquqfc6MmlyvCKhkOqSltEPsHF4GGyMXsG++ZZGgdSzZP3JBAr96X8C7QoQG3Pz6Y64G4M9rQvRfVJZwuovXt6q+xi9CJzsZX0POcyO53qpz/+pL+NohIbU2A14MgEnEzVMbHY050tXKTdQkpjZSbRFbkkuCT4dh+6j0bhX7UjGDEq5dgaAYLvcjJf8lU01rM0HhMjo2hc2DUv1LiWB7X/45sOUOcstCvZtQy80zXAZLs1qjZGNxiOrgTc/r11aoQ30UC1ts1CzWB48J0P05IuFRUuhkN0DeDrfSdDIbMtIVMHsHWAl7vU84aWPgdLsLIpUxLKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765452805; c=relaxed/relaxed;
	bh=phiy9ied8gdfxveKkebHqanag2hE7Otb50tt4bxl1+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awY6kXZp8+K2HzcNF3zzUD+w2qvEwe2KA2JYe/zFn2EohEDUUp2iPLlRQDH8oP23/Rrm0Iml1ULY5rfLbEtrjluRpvvjXN3JNbxQIlUdohQAGiS6I8g593MldYE/0b8VDzPZiRdolaF0b2NOdNYJXYyyzry4K7eCAq2edtozfWQNKZEOF2CD7rgW7mvVSqbdrlSB9bTdNzHviSfFdELXVj7ks/0HAiHXGvo6FcsUeoxcX9aF3QurZn1wEnN7+SsCKZdwQel21a3AN7Jb9NQLWltxeOPUS94QLYzQ3Wvsr5XgajQ7H2Q5V+62u1t2i0f20LTYSTjeRaEYl+HWtOHPUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yGEhlB92; dkim-atps=neutral; spf=pass (client-ip=74.125.224.49; helo=mail-yx1-f49.google.com; envelope-from=ulf.hansson@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yGEhlB92;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=74.125.224.49; helo=mail-yx1-f49.google.com; envelope-from=ulf.hansson@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dRr7S3bDSz2xNk
	for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Dec 2025 22:33:24 +1100 (AEDT)
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6447743ce59so806465d50.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Dec 2025 03:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765452742; x=1766057542; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=phiy9ied8gdfxveKkebHqanag2hE7Otb50tt4bxl1+s=;
        b=yGEhlB92E9tSv7yMeEbG+SJ/1lMLtCv/yGGbQZCX32vp+PKh8VNunhtnnwLXjx+Km8
         2vDpPZDdMlbr06C7t0cLpv+hal9N2nUXeaANlPiqgRKFxLqqT6xk8LT1uTc6kXqEpP4Q
         8bO3Fgo1LUxtMDb+dhvQrt6gA9YqAxuaG6njbAQJlNJIk+fd8GGfYEvWfm20iEYKCsba
         Mcaby0kbbtRH+33xtIchYKiy92XuhXj5C7H0qwEmMMJ/CvLuZrdrfMUWCkVHkmYGo8XE
         MfVJvgDi+5n57PrNLzwOwJlycLbsBoSyHDi7bLB32llXGGucoSvCkWgp5jISA/c6ProF
         xJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765452742; x=1766057542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phiy9ied8gdfxveKkebHqanag2hE7Otb50tt4bxl1+s=;
        b=SUQUVIxOTLfB3z/Ld5rK8JCjd5LUnvJOlqe96K+qRYl4DpNOuf6zIThJi7Uu2n83MP
         PNLKbh8OkCPT67E0QeJN6J56NB9BtfAAN7x0Qkf4ZakvRwc3rdr5u65REOzuO+0GpNDC
         4oAarjoMmz+Oov1IEvH7IL6OjcrYcUYYBG2bHsvrtcM/Akg7DtnQQLXVPF7XKqYbgP1p
         CbwpaHNXlFzw4YqL8iRO5mk6+B/0g01BmUiLdalVe4yuBKoz0/YiATydo8MpxYd6TVaR
         ijtMpkB62c0TxfbNx9ea3reIGdNDcyYEu/r2IWsfLfbhqZBIwdRwxlaAxm1vwT3zsv4v
         +WpA==
X-Forwarded-Encrypted: i=1; AJvYcCV8vO5Kv2xGICSVTn6bsmgIsRk3UGiPh2gG4kwuMsiUt8hgxmKIX3SawHWe18LiT/4kkrgXIssWScobPGU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwouyfKYhG8lYacNiuVK3QetSq2tT5hlvpaUpDXCu3xKE8JkCIm
	Q0SjmlUpiiwnSg/DP1i4C3s/gvUupvh/7fkNo81Jz9OQDpfTOLE50bgXVMT9wJMAbrk1b2lBMn4
	RvE341/TVP+fCuKEQEA3lFvoxx1wHvAbFqWD5XD+KRQ==
X-Gm-Gg: AY/fxX72FZeJtEUDI9cARTdT6SjH8tu1oYUt0/Cc/3x/pBiN4/Cvga2uc63Xs2H/ruX
	rOPiqaN1gEFTOVNRQxSt+JOGvLX/Jc/n6wrgWQrjO78pTmsmoWHG3F32WQ2iTa/KFLsYvxFGyrj
	+seUYz20zt0qaXR4oocVMuxcQO4C8SWIPVmdymr2qrZIcIF+1wJ7fCbObipadTxDrYLoaNvAGv+
	OsUXdNaT1Ruxfc9Bq8d2si843NgrNK9RWM14V7nTiziT7apaZn1EdnwXn/1K5fO0itgbISm
X-Google-Smtp-Source: AGHT+IGcqwaxtfJMJnD56RcASi/uVKO/lK/0JnQ8qMBQTGtHR3OnnoyAdnC7R6PIycF4XsJLibnnvktvbwIlYjUAVZY=
X-Received: by 2002:a05:690e:120e:b0:63f:96d7:a350 with SMTP id
 956f58d0204a3-6446eb4a92cmr4347837d50.66.1765452742333; Thu, 11 Dec 2025
 03:32:22 -0800 (PST)
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
 <20251211-dev-dt-warnings-all-v1-7-21b18b9ada77@codeconstruct.com.au>
In-Reply-To: <20251211-dev-dt-warnings-all-v1-7-21b18b9ada77@codeconstruct.com.au>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Dec 2025 12:31:45 +0100
X-Gm-Features: AQt7F2oiHWORIK5IUrdndTpX-opjO6A0dESgetC9ddqm2QKKAaLxTanuvA5lEio
Message-ID: <CAPDyKFqZQUurBNSNUBKE7rgBf+UHxKiYBWt+xxSY+dh7PgdPPQ@mail.gmail.com>
Subject: Re: [PATCH RFC 07/16] ARM: dts: aspeed: Remove sdhci-drive-type
 property from AST2600 EVB
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
> The property isn't specified in the bindings and is not used by the
> corresponding driver, so drop it.
>
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>

FWIW:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>


> ---
>  arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> index de83c0eb1d6e..3eba676e57f1 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> @@ -314,7 +314,6 @@ &sdhci0 {
>         status = "okay";
>         bus-width = <4>;
>         max-frequency = <100000000>;
> -       sdhci-drive-type = /bits/ 8 <3>;
>         sdhci-caps-mask = <0x7 0x0>;
>         sdhci,wp-inverted;
>         vmmc-supply = <&vcc_sdhci0>;
> @@ -326,7 +325,6 @@ &sdhci1 {
>         status = "okay";
>         bus-width = <4>;
>         max-frequency = <100000000>;
> -       sdhci-drive-type = /bits/ 8 <3>;
>         sdhci-caps-mask = <0x7 0x0>;
>         sdhci,wp-inverted;
>         vmmc-supply = <&vcc_sdhci1>;
>
> --
> 2.47.3
>
>

