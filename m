Return-Path: <linux-aspeed+bounces-1275-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43EFC5AD49
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 May 2025 16:47:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b6wQP48VBz2xQ5;
	Thu, 29 May 2025 02:47:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748450829;
	cv=none; b=JdaA2+/ZDLWOREunhi0HKe4XcEYnle8W0qQhSA4JPGvubRvR3SRG2R67ZprphnZiHZADxMA9JJh4QAkfXUUf9kLQrsfsVDKBg6pVDkJM5zgUXv9PPcmWxlryEvRIv7a+RvDBo5uBBo0kyKY/TeMx+QiqYw7nfdJGV2sBjsWvJkAoItUu632PDkdr64XPAqJIKkpnufM+UarJJAxK3cx/MlhHWGSqvgfod9EGxZlALtnLE1jsHAWm3IJ/Db4Bb8nGKIrq3VEEar8QJ3LNJSCNe0xx7MWiCO+4HzdnFoPtET2IFJCUEL5UBSa32d34YyRcZNrSvO//s6eOE/A1M0aWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748450829; c=relaxed/relaxed;
	bh=bTrLQar6gjTjFnrAkyn0kezzixoXN+IjT1tsTT4veX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIGCNrzlVIZa/2IBW5lcYs8vl3whCbHzaIWU++qAAd/VpKuPN3OjfpgqLdmE93PDW4Cn82xkyOdmSsICqp9rIY0ues1GCgq4cslyoy/ARBCN35mwW/F47I4H+LjHTvGiK9uO6HRkYlYDurX9BCVOq0/LO1uSL2RFBSEXCXAD3Jj21WXtqy2ncqXyWAhU2bhEiQx+AT0tU6g3PTAO8otVCgN0qukQRfr9OaecKybIX00/cMcfgjK2VuMccddopnkTHC1VjFYAm7gcJ87sHnIT1spSdRmD3ylboOl8UxSAHFcuw53apn72t2GatbeC5vSvL4qT/VjN3+2r7a0L0ziaLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=YDFWaGyr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=florian.fainelli@broadcom.com; receiver=lists.ozlabs.org) smtp.mailfrom=broadcom.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=YDFWaGyr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=broadcom.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=florian.fainelli@broadcom.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b6wQN3TDGz2xCW
	for <linux-aspeed@lists.ozlabs.org>; Thu, 29 May 2025 02:47:08 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-3119822df05so2750102a91.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 28 May 2025 09:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748450827; x=1749055627; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bTrLQar6gjTjFnrAkyn0kezzixoXN+IjT1tsTT4veX4=;
        b=YDFWaGyrGphyGvvkwIC/X4QMdj7VrDp1TSIK1DPBUtiBUIzq52QyHbonv/OUsvszOo
         AZ4q74RyEunEMfWMRYPr7ZIvXOwAwlaqxoWhQUnnZWazAEfbhcwFMByHJxVok1KupRNQ
         dVSNwmc32kiiw/VnXKTgOCe1IlpvkPe5pQDzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748450827; x=1749055627;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTrLQar6gjTjFnrAkyn0kezzixoXN+IjT1tsTT4veX4=;
        b=u3YSa45zKdR1/sZ4CCyFf3/nQncaDp+xAcksasdpudb3hhtTI0Njc5ew1/wTrCwQ14
         I8ShYQgnmGbkdrDchd9zTsHjRdEogwnn6VuHYmmDvlQVPqiUG7WRbqW3VQmPSB+5vQg3
         Q/mzO3eskysbEvME41VqNeVGJYwBmeZWnbPxnA3qr50QiBZ7W2lASsr4Wqa+iZ2us4YR
         hUCs05TpHMQnJx2505rwRljv9XE33bpKUfFX7HszqsE25PPVokwz685IzHpSRwmQcQXx
         HU56OL4JYZmu88xgMNiLAhg6se1G3Tc5/t8wzsbn42L5EVQz1/dRObGGGbRcKgbWmQwj
         a8Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVIEzUH9Q7+TMcxgLjIKE/tBbs665FWUMhOAXonBwcKiFsL74eEpOFIqq6fmnWG03/tLuXz3Ug1aZkNF30=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxspZ/NX5MLRZQgU/0yv7+yfQfLbptAE8uM8rCOK+G1LwOGpRcA
	/yOTdeLP25er3adRrhWepjztL+r49xiTuCM9sqxgbooF3kFYz5eLSew4RXOpqpgkEw==
X-Gm-Gg: ASbGncuZyGrdLJ2QgRdPEA3JYVDGkMFDO0aOGTcEnrqiHsuV06PI1zqYPGGxxT7TJYP
	BFeAYMxWMi+FDcc//shPXflmi+J865pz6zxTdRffEyVf3lFkOmMMEDz9dhhWj+jYuDN0vpqZuC2
	m1qcWXSEQQWjPbV7Ft8beTTczm+Tv1eYWfCZ1QTPH96/6ooz5/g2I1im2LYnvgHGFbURgLbyPgq
	869Zrd0g0dBAVPVdtdNTnBQRn1C9GdVmAb8dnnOVOmA39Q2RqRrYPjnwvRpznOQ02CD4Nsa4xuD
	nAWTg4JnDxAbEEPD/w7pKVlqIJc+3htn7wQDAHg7HL7jyprdeYMdqM7sqqZm8AbyPCGvf2iBFTg
	oo3kCr5xRZy4faPg=
X-Google-Smtp-Source: AGHT+IH0GIOB3le0IKYtPmRR7AMZV+k2FqHC9XHWUmEUEohQfd4DCCGdhmzJ/UzDzReG9+UWi+j8Kw==
X-Received: by 2002:a17:90b:3651:b0:311:a4d6:30f8 with SMTP id 98e67ed59e1d1-311a4d630ffmr9297166a91.13.1748450826671;
        Wed, 28 May 2025 09:47:06 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-311e46ce2b1sm1520552a91.36.2025.05.28.09.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 09:47:06 -0700 (PDT)
Message-ID: <c92b138d-3c8a-4b14-978e-0274301768df@broadcom.com>
Date: Wed, 28 May 2025 09:46:57 -0700
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] pinctrl: bcm: cygnus-nsp: Move fixed assignments to
 'pinctrl_desc' definition
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>,
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>,
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>,
 =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Lars Persson <lars.persson@axis.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Damien Le Moal <dlemoal@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>,
 Michal Simek <michal.simek@amd.com>, Emil Renner Berthing <kernel@esmil.dk>,
 Jianlong Huang <jianlong.huang@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@axis.com,
 linux-riscv@lists.infradead.org, linux-rtc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250528-pinctrl-const-desc-v1-0-76fe97899945@linaro.org>
 <20250528-pinctrl-const-desc-v1-10-76fe97899945@linaro.org>
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
In-Reply-To: <20250528-pinctrl-const-desc-v1-10-76fe97899945@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/25 03:41, Krzysztof Kozlowski wrote:
> Assign 'struct pinctrl_desc' .npins member in definition to make clear
> that number of pins is fixed and have less code in the probe.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

