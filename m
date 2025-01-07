Return-Path: <linux-aspeed+bounces-340-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F13E77197
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Jan 2025 17:27:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSHzV27NGz2yhM;
	Wed,  8 Jan 2025 04:27:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736270822;
	cv=none; b=KkZUBVd1gbx2z1MmITUfFD8zcvlbP41RZPQMP80mC2fxr/fyWyPbbl5kXLjG3v2tuIjLbIdyAXsbkFL+Too6QXN8JK0JiKjvxipqTY3zOXIPeVubsIJLpatwwDc1WZaV0KQzKRsjlVUErfLShmbFMLD4WNGcn9uh/pGYMJwOf/m+/m1Suxm1Yy/383MQQBEVuUMDycgmpq4ZnW7Nlxqt+BuDSt1z4On82Krrlouq99JaKDbKQ5kn75TyxfDL8mg5bCXMBUO4QpwqSyPwaj2kgc8Q4cq3NE7/BkoT0Lh0a2S8Qio5m/e05vA2yzLM4Ko6Aiot52ScS5cyH/JkthOYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736270822; c=relaxed/relaxed;
	bh=AnFDI1orT78UbMz4dvewuX8lguog+6111daL66A0sXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kQ9YMkFBY6Pr/z7YOOrbocRqxGjTICGMOoeQdGRWFaPW5q0wos4kj2wCv6cgEhxwYlZrpZNgoI+xvobCRaahV6FDYNh3A/KOFz4lkcDt2Y2PGmH4mPnZinWRBK8Rc1pmhx+blWF7cAGxwFaSQy8dgULaOu5QSFAiHAWKYt24P9OpympoJW+lSDnvt88N+RLbmslqwCxelgp1kQpGm/AtIwHWQiR05+i8L9meNoHPxGkLyg/rRNIec9E8A4+X1Nb65f48BDqo5fE+p0i3CCjwwmRv6BtWgGd8/jKKC17wS6cokrgRFbh8qDtW7eHZEZuXoYgDtVpkthM/gTUY1k7R5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=f+L/xFkv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=florian.fainelli@broadcom.com; receiver=lists.ozlabs.org) smtp.mailfrom=broadcom.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=f+L/xFkv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=broadcom.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=florian.fainelli@broadcom.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSHzP4YnXz2yVV
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Jan 2025 04:26:53 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-21644aca3a0so56511455ad.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Jan 2025 09:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736270811; x=1736875611; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AnFDI1orT78UbMz4dvewuX8lguog+6111daL66A0sXs=;
        b=f+L/xFkvmyHPJAcU/Iuer2R2CryWTbcYk3027fvcqwmhvSNuDcHilLowGRCLhP8LYD
         FEgL6wB8+b3deFLspy+GOI7VgEUQTVbwXJhCDpneRtkQlUK8/vVI1dXOSpKKcTnuK+fF
         P6xyOaR1IdDnpSWplZY+H8SxN+YMBDSBdHYRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736270811; x=1736875611;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AnFDI1orT78UbMz4dvewuX8lguog+6111daL66A0sXs=;
        b=IuVLYPzs330dp3UEwg6oNph2enDTb0T8zhH3RuekD+aTMCk3rr+xM0uaAief8cDWDO
         xbksT533Vhw4t1WYmPzf3CSPpfmspGLUzCZEVVaM0YmHLZ+vzwoAtHsDZtFGYzIpny7v
         4g/zoMqUJEw5vjBOYvTgzYyRR5kDy/4J2qylsqx8FqHknhE7ocSveLgyaIwjSynoXTim
         9jIrr4lxlWT6CZau47zKNuAuT+2egnAe/JdVAkDct8cT9JdjMfOKBE2gk2PLmUn0b+s+
         f7s+NKhtbqiI0Ns0t9Thx7Kgp3XXhbKw8NRlOBL9FgdLtwlCAkGdr71sOYuAn+gK8vmf
         Zlgg==
X-Forwarded-Encrypted: i=1; AJvYcCXliFEx6c1hQXxdv2v+0a9tJm1NKJsX4attNU7kc5PSocHTjVCFoipi6nxVdjaNhnaik7O0mR5PxRJdFBY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxmDcAiXczGxH+HrUNc5fh9wOTNhSIK9At3vHJ6Olc0AC5THZdO
	Ph/g/2aZr4SGciV7NmRmkQuJnm4sNl1o9CM/kyJEH1cFrTGBPh78qBDfhdzh6Q==
X-Gm-Gg: ASbGncujWbSPWxB2Nl/yyXIUfnTe6ytZLESbOB8/F/7NWUQehcAwqyHFjhXTXXwg835
	JHFaxH9hQn8SMEImPOUxoERz69jPdXZeH2RJlPFk6Aud4q/LmVmm/VB1IBFyIzMpKi5pulsqDIs
	n4YyRK9T06Ogmvg+PVhIzQ78PQMBJiifvMW1Uec2KfH2HfL/abQ5KY9cgmOWL5SldoxAPqdXb+7
	/ueUToJgKaKSwSE/2eYegKhsXtDSKHW8NpIvy1MNPQYqPphM3lvOZdZhbVrJ0URczKCS8PjH4v4
	fc5goZlKDexoClj+G2Db
X-Google-Smtp-Source: AGHT+IEPaGgB9Qa+1DpEpRgPYql8+QmamIMyRh5C1Rx/DzqtHoRCh+8H9eqIioceJgqABRLUqu9iOw==
X-Received: by 2002:a17:902:c408:b0:216:4d1f:5c83 with SMTP id d9443c01a7336-219e6f26814mr803886345ad.47.1736270810779;
        Tue, 07 Jan 2025 09:26:50 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cdeccsm314093865ad.144.2025.01.07.09.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 09:26:49 -0800 (PST)
Message-ID: <e2d33d2f-6b30-495e-a089-b1185b22130f@broadcom.com>
Date: Tue, 7 Jan 2025 09:26:46 -0800
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
Subject: Re: [PATCH] dt-bindings: usb: Correct indentation and style in DTS
 example
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Justin Chen <justin.chen@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Benjamin Bara <benjamin.bara@skidata.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
 Del Regno <angelogioacchino.delregno@collabora.com>,
 Tianping Fang <tianping.fang@mediatek.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20250107131015.246461-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20250107131015.246461-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/7/25 05:10, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
> 
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../bindings/usb/aspeed,usb-vhub.yaml         | 40 +++++++++----------
>   .../devicetree/bindings/usb/brcm,bdc.yaml     | 14 +++----

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com> # brcm,bdc.yaml
-- 
Florian

