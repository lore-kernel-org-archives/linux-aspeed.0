Return-Path: <linux-aspeed+bounces-3088-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157E8D41C1F
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Dec 2025 11:33:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dRr7Q17Z9z2xqr;
	Thu, 11 Dec 2025 22:33:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.224.50
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765452802;
	cv=none; b=k2Sd7vjE8HYzAqSfyNLfLhVK6qjXTqX+qtnFlWtavea/0XbAv8YV3dEAUloTJjZIbIhOLIKd906whNWqvPi/y/GYDKcYBqE389tJyGDGWzG9PNieyr1aE6kAU+OUWnUxrBoaKa6RovhozkVnb1ZU6lwKZKkg2yC1HIiu2q6yPl2xZr6JUQ4k2OZNt22b1emhinNvZju4mesBdW3imV/grYseEAmtMTj+2GG7useAi40//O140LgkCeILkgWtHbakviA/wzOAAl8Tx6wp6elLioFSRD8T3yBN/OC3flfxZ5MAsVwiH8UtIZML/FIiCwQXBRdthuead5azchWBVR6Adw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765452802; c=relaxed/relaxed;
	bh=vAvAduq0/fXRtJhO0coRhdPgTbJSI1bNLnmdQnPpfuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7vYJULwYQxYhSdpGcNsi09DIh9p3fFx6VshMsHXxP7Zh5ovn+CAzRz2M36TXXIO6SSWYWkv9M8U4LSfkBJdA1vNk1W+k1a/OVZZvY9ho2u0POrWLPTjkzOqdqN/KT7mev6LBonk+/WC0ANhLViQXf6E1dNh7of0OnsM9Jcit/0R6Ev29s+NVOd8JHgU0bxOR4V7tKVD84b0AGVu5b/cZvPer4f7oLtkWUqdE/druz6SM7hIU3emMDLD4JAyeElTLXBQwYacUHjhXx5xBmn6uEprVIH1UilYqpaab+0k2flPUyXBRUcBJ1O9Zem3/iRZ6pAhm6O7xETztgz1WUGAOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZjaVSZBH; dkim-atps=neutral; spf=pass (client-ip=74.125.224.50; helo=mail-yx1-f50.google.com; envelope-from=ulf.hansson@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZjaVSZBH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=74.125.224.50; helo=mail-yx1-f50.google.com; envelope-from=ulf.hansson@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dRr7N2klQz2xLR
	for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Dec 2025 22:33:19 +1100 (AEDT)
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-640e065991dso749926d50.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Dec 2025 03:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765452735; x=1766057535; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vAvAduq0/fXRtJhO0coRhdPgTbJSI1bNLnmdQnPpfuY=;
        b=ZjaVSZBHkcf6qiit7EyoUMAUWUUVsK8VaqrL5RaqXGkB2epp4msMb8XqIPdgXIsdhF
         KCWxdfqvuBk0/cAbmi8i1pd5ofcPg5g9eUEvsnH0vjXATG1mW3s67eMhuihTW3EYf2Yw
         JBC/4YyDJclM9PlKvUtEn4rpWf/7F6qfqghfilkg6fwioriWMdq7auqm2K0MkIuh8gH9
         p0gDDN7s/YqPr4PD5vggIBVayvg+Suq15xg/AggDqG7S1OF3Al3YzzqqmE6Uu8fR1/yM
         Crd3crTvOZqVroXTo7yICKd9uWPp/00pd/c+468ZvD1gYV5+3mNoplfWRMXSm/VM1Lt1
         QwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765452735; x=1766057535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAvAduq0/fXRtJhO0coRhdPgTbJSI1bNLnmdQnPpfuY=;
        b=D/s0m8F1UvqrWEB5ga6AlINqe7sAOziXHVKHk4vbHzABqx9QyIZgenZfeLH0F0tg1h
         LkqDVYJuvEfwnLwL6KrlTLPKgdmMiDqZoqyYQypDPa1y/JJTAEtZS8XlJbhC3YMa57N1
         Wmyiv/iCIkMFqwpGrkfiEQpsKQDvX6BLU53Qo6RHY25Z2ZxWkG5GsZtwJuFThX8uyano
         1hIGpvW7e30q0Pqca0Xo4hkPQkLi5o1p6Z0ZV3HM9ZEHIQs9LijDGHDY5hCyEGWfY1vU
         +1w3c4tRfNLxHNC9rXrva4fRrNIEc4RUNbNJ6YiuGp10xFp8ciESfdazu72/QK2yo8VS
         +NkA==
X-Forwarded-Encrypted: i=1; AJvYcCVE6xU0D6QMBiIP/FDb6L4TE1jTkweQWWO9QlpTYWkjFQPOsz0c+ddYWHq6mqG6fyErKhUbgNtzozTLC7s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy87EZXAgU3THq+E5BXZpxhel+xebxK0OAqZfvKwn7LklehgXQw
	MJZoFV87RRApL0MFv0oEL2VefnyWN+gb0O7K+7skU7JmAxJR0YoieyBwqzxPTFR19TF/I7pbO5+
	PNFty177hstuL0r06GORz+wXMQU4pyjf9OyPDgNOQSA==
X-Gm-Gg: AY/fxX66TSwFygl7jPokwh6IHz4Yv6E1ZaAB4ne9zhcXec1EXxM4o8brdsVDQam+2af
	ohMH8hEGHfmPXNNzI4y1H0PtwxxvGTOGMXmWRDnOV1iEqAW9E1oyURzVJKr64wNxidkMxTuBlFB
	YOBC04PRVsDazQzj/FfKDHI2XHxZQvKe4DXOV0nz0wEurAx6jyUfzt2zJJad9+Oi7Dq960bvD3R
	/nW3+yFJtxJDBuLW++EldiFd5c4V9Yu2DeP7MBBHIXfhTToooJKv1sIx7jIea4lQGa4e/Ha0RV8
	dDS/uLA=
X-Google-Smtp-Source: AGHT+IG8bNJ7GVmxCtKmkFoNf2sieoYkv2mgOPVq2xJndKf37hgXCewb4eZsd1D0ffqnRQUAE3M4kyCHgtlEMcMmN4I=
X-Received: by 2002:a05:690e:191b:b0:640:db57:8d95 with SMTP id
 956f58d0204a3-6446eb3aa4emr5006636d50.63.1765452735377; Thu, 11 Dec 2025
 03:32:15 -0800 (PST)
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
 <20251211-dev-dt-warnings-all-v1-6-21b18b9ada77@codeconstruct.com.au>
In-Reply-To: <20251211-dev-dt-warnings-all-v1-6-21b18b9ada77@codeconstruct.com.au>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Dec 2025 12:31:38 +0100
X-Gm-Features: AQt7F2pSIRmWc3gz3aUnvZCl6QhFMFW_pPE_bkwFhLy-FhbClf3aqE2_J1pJY4M
Message-ID: <CAPDyKFrbS_3XRTSuexFxTpP1ydgvfFvXNv_tninnTqum7+92ZA@mail.gmail.com>
Subject: Re: [PATCH RFC 06/16] dt-bindings: mmc: Switch ref to sdhci-common.yaml
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
> Enable use of common SDHCI-related properties such as sdhci-caps-mask as
> found in the AST2600 EVB DTS.
>
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Applied for fixes and by adding a stable-tag, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> index 9fce8cd7b0b6..d24950ccea95 100644
> --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> @@ -41,7 +41,7 @@ properties:
>  patternProperties:
>    "^sdhci@[0-9a-f]+$":
>      type: object
> -    $ref: mmc-controller.yaml
> +    $ref: sdhci-common.yaml
>      unevaluatedProperties: false
>
>      properties:
>
> --
> 2.47.3
>
>

