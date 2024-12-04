Return-Path: <linux-aspeed+bounces-180-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E011E7716D
	for <linux-aspeed@archiver.kernel.org>; Wed,  4 Dec 2024 07:21:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y388r5btMz30VS;
	Wed,  4 Dec 2024 18:21:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733296908;
	cv=none; b=Piu6Q5y7+loavZSlKOF/FVshG684jUVpBkFjpAJyiVu9BcleJDXB5HN+qJMQbIRYHU8VsKydzgIKbWxU3r9CfgBuhOe4+frdtX9y3Qx+YrSLtMD7f5go00yamZzVXnPiMeDPe/IMSIaQzoUPvbfr1Is0AsaWqdG3+vIOhyCf8Hjh0PM5H8Y/Rz2g8m1mcOO5Uia7lZv2ztQLAuJ33asYPhjVYz6TjjqYXjnCaLQGcf5cjqbJXl1V2PUfoUlTO9NffJFhcLqghluokkp5N4Xa9JbvJZgkYKXxtRveLqI/HwZgUCIeXL9be1pAke8vw7E6rwL/0nrCiMspzkkqaEKjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733296908; c=relaxed/relaxed;
	bh=X1xLPBUzUotQ8W4dnkHC8pvofzpJw52qNUZu5+hvGuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0tF8J9/bcjPiSn55H/c7regyhi6GqpkQdVaLwmklxZJznE6RTSD1vltHucfObj5H52/smDJne/OZ6DTslMjIhnsPkmxd5QpfFo+TaEQAyHVDfdlvhR3FxrHCfidXTco5X/CHvGOHoBBa3/DVZdZIBW3wLn0ZOh17w3LpA2oyllOPRmqQ84E/VeszGtu9tfUx3mrlON5ihpJXtT0U0IA9NmF7JyLQAHBDGrGoUk7x+fRYM9vlfyBbnJQIO57CUaBWNs/iqHPliL/25H8UtkrrzCSDspiUYOljSu1vDp180rzqa76FQr90ERdyXyNio8igVIcmE3WqjE/ZbYLREL0Lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DEDVPZLw; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DEDVPZLw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=krzysztof.kozlowski@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y388p2t0Fz30Sy
	for <linux-aspeed@lists.ozlabs.org>; Wed,  4 Dec 2024 18:21:44 +1100 (AEDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4349fe119a8so7564295e9.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 03 Dec 2024 23:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733296899; x=1733901699; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X1xLPBUzUotQ8W4dnkHC8pvofzpJw52qNUZu5+hvGuQ=;
        b=DEDVPZLwTr6bZuGtUQcpkTmipIN9WGWr+XGyVYVo7Zoa7mfZyoOsiFhDz2jYp23VAC
         KRce9wdBLdJtc1oGOzUH2znBCwHM4Tz3gcYV9he+YjVKHy/yzuqqkUYg9dR9l/GHr/oD
         tyFw7qdaJjpqAQeg1njFUF15Akm9LdAEV8VE+9mHRJIzGmqnP+PjOtTgLaNlwRoatWKl
         SRAa5gY+oDKGz1L0/a3TJ1mFkJ8jAqme5WqDW5VOY+tXub2XIMeekW5d6DKNjVazht7h
         FndUcwFzh7s9wPTeynd2W+FDeiuZs+0t7V4QFt3Ha9TchDYqR+EWTWFcgl0fVSTogZ6l
         f/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733296899; x=1733901699;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1xLPBUzUotQ8W4dnkHC8pvofzpJw52qNUZu5+hvGuQ=;
        b=MsCnPX0uAHbxgJgYDFIWAv6JcBPYTsVLmH9PtOUTzYFRL4VDNaGIF1+UBoyAH6spBq
         uSrsvbRq5fGoMRPtrlzBUUUAk3d6nI4Y6tDTU1eQfHx79iwf1aPoyMRRmbqGnwdPOAgh
         PMS/LazwBgDFbGYAzpOvBKFHilEhrNU6vgiaUXvpVPLtwEm83PYBYHyLx3IDq/U/SH2C
         cTKFasVGBYqIorYumOixw2w9mHFQ8E3WhVbvHN9gRmL8IJg5n+gX97g5lE6NsvByiYUE
         8j0TXD07MeSeomi1yjYRl2TNxmv9dP2Ssj0XzwRmyif1vUVIv5Rs+F9WO7YNVZrMnf2f
         W5bw==
X-Forwarded-Encrypted: i=1; AJvYcCV5CDWiSF1qsmoZYXDQWrj2U5bjp9qF0PB3pLANy2+2+7KQqaX3ZTy7/TAI/KftKOI6ROXfQg2GNXP2ANs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxcni4ulv+eHiIkHrUGjomipAmDlqqLgeEXK42I4TgdIWcpvoW/
	mdTjbbR25D55lt5q+7WG1avABiXlOtHiQZy7z2OCsv5QNy20SQYihsH5kmGdsqY=
X-Gm-Gg: ASbGnctfXvD/KA7PFdhBnYeCI/p70D7HUSNchk0AqG0L/5ina9HHpQ5I8krnoJ7DjiF
	37OtwOebDMCtn6NA2Pt/S9a6e1qEtT5qVt8LdZl1OEduzOnrFFZNsM6EaAfzT7yZTRfwA7jAEB/
	ptwXmaWPpkf0aiAypCUHgqpFcD2xIbUaAXJ4H/lX05bBO7/7BApN8yx2qvTCjKuuZkGPi/PA35v
	gfmrP+2wD9sQGgRTEwGuVHfLlTq+mzD/1y7n18QhNUBybYBHijtxrYrHWjQVO4Y6C1z+w==
X-Google-Smtp-Source: AGHT+IHtCdQ05BQDY20/LpYx6IfP8mgaeR10Q3ey/YZ+JByIUyxE2J/jobAU8fTKHzVmlAdPD/L43Q==
X-Received: by 2002:a05:600c:1ca2:b0:42c:b63d:df3 with SMTP id 5b1f17b1804b1-434d09055a8mr17717385e9.0.1733296898918;
        Tue, 03 Dec 2024 23:21:38 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52aa0b4sm13924315e9.35.2024.12.03.23.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 23:21:38 -0800 (PST)
Message-ID: <068c4e43-d64c-4f08-abff-675334e8f5e9@linaro.org>
Date: Wed, 4 Dec 2024 08:21:36 +0100
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: aspeed: Enable video engine for IBM System1
To: manojkiran.eda@gmail.com, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Eddie James <eajames@linux.ibm.com>, Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org
References: <20241203-dts-system1-video-v1-1-008e5e660106@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241203-dts-system1-video-v1-1-008e5e660106@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/12/2024 14:22, Manojkiran Eda via B4 Relay wrote:
> From: Manojkiran Eda <manojkiran.eda@gmail.com>
> 
> Signed-off-by: Manojkiran Eda <manojkiran.eda@gmail.com>
You CC-ed an address, which suggests you do not work on mainline kernel
or you do not use get_maintainers.pl/b4/patman. Regardless of the
reason, process needs improvement: please CC correct address.

Best regards,
Krzysztof

