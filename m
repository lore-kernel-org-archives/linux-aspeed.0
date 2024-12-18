Return-Path: <linux-aspeed+bounces-278-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFB9E77183
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Dec 2024 08:11:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YCmc100JPz2xjQ;
	Wed, 18 Dec 2024 19:11:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734509504;
	cv=none; b=JjWSl5U7R/7AzA4jM0wHD4kEsk53OOV/E6YKEl3RUG2jwZrS6g3DJOg/Qir9Q7dZNpmWYQWgTf4KLyqy4GWEvpZOxM3vNI3vs7uBOl4LbszsFcv1kplnnkHA6Lo8uVCnuETJOAfpdf20VtTfNTK2Den0DtTPDihyeEhT3mBndk+lY41SmfRmmxxJyn5xz3FkgU4Ajv8wQkCufOgwj9eXcX3DTh2UV7PYla0OvTt5TI7CtvY3nfmSjM+ZYuQxBJFE24PhndsTVa4G4xHph2eQ5jP3vG7P1esdFu2lhiQ+KcpUGLowr7ffPLcUw2WDWgDh4NgmfBtdv5yX1ETB5y2wRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734509504; c=relaxed/relaxed;
	bh=juKhwfg+Frw7VM5RTNeQJHLkr65oOosI9cDLDXSk6fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IpU2zdvKv2Ans5hVg5p2/bNmvCCiVjekPSRu9i9z5XVnOCYvBYBMsZjlUbc1eJO6tcGPTZI/9KUrwq2IMq++hLnZ7UYJKCsKerX58a1/EhJ/OpoPJ29+j0A8bQFmvhuRcmcUEaqzYM31XR0DT3yAh3HBvsAzBsEfEqTCMkbxjpSIyp6JRO5y+Vxm5MbIWmxBLg8VRqVbflP4iF3wgeSbbMW4B7aBzHfeFKFo6UeJbDWa5FTswOdOtbEzjHHzj7tHncMWflUp4j9/KSqezqxs2aNRyBAth2uIHJ3Fcmk4TTneQoBJy4RT+pZukZQkowNm075ORNviMqw2eKH2T39dKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mH8otsfK; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mH8otsfK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YCmbz6PpSz2xfB
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Dec 2024 19:11:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 63C47A424F8;
	Wed, 18 Dec 2024 08:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A524C4CED4;
	Wed, 18 Dec 2024 08:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734509500;
	bh=GD+XRq2BWDzrYgMfELDkBiixgET0u+IfEAOVp79m8/c=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=mH8otsfKPIZaIn7z2+Vlzh/Bllp9tXet1lPJLKt9j8l4aKn06FGLkfOiRD7LRDhBg
	 8jXKz8KGdJyULSDVR6vgkU+cdNujljJdM15ovpUZGRYdiEQvGHe6P/AbGY+78T69So
	 MBflpqIjqZKi4A8T1fEyx3H0r5OxeI8b0K6ZWdOUtbyAcnXUtq1MiWXYFiJCE3v+55
	 q0WBwsyYNU3JAZJHAXVphTnt2x+Q2VCuYhMGKz9pmMFzkjoetCpxMv1aZLOBMSWxmZ
	 wBmJXS2fDhiExrmSIkiOm9vuyVpgL9cDK+4X6u7m9cUlmnVkoevOyfHMedxR6PAQtm
	 R2QEyLou8zsAA==
Message-ID: <4717dbb3-4fea-4ca0-800e-07ceed4dfec0@kernel.org>
Date: Wed, 18 Dec 2024 09:11:31 +0100
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
Subject: Re: [PATCH v3 2/6] dt-bindings: arm: aspeed: Add ASPEED AST27XX SoC
To: Kevin Chen <kevin_chen@aspeedtech.com>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
 <joel@jms.id.au>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
 "olof@lixom.net" <olof@lixom.net>,
 "quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
 "konradybcio@kernel.org" <konradybcio@kernel.org>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "johan+linaro@kernel.org" <johan+linaro@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "soc@lists.linux.dev" <soc@lists.linux.dev>
References: <20241212155237.848336-1-kevin_chen@aspeedtech.com>
 <20241212155237.848336-4-kevin_chen@aspeedtech.com>
 <7289a50a-e139-453f-a512-3dd68a0839a2@kernel.org>
 <7b991fca-6e2f-454f-a94d-6a583854769b@kernel.org>
 <PSAPR06MB49495C182D0B64687E0174A389052@PSAPR06MB4949.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <PSAPR06MB49495C182D0B64687E0174A389052@PSAPR06MB4949.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/12/2024 03:55, Kevin Chen wrote:
> Hi Krzk,
> 
>>> On 12/12/2024 16:52, Kevin Chen wrote:
>>>> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>>>> b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>>>> index 2f92b8ab08fa..20191fee1f5b 100644
>>>> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>>>> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>>>> @@ -101,4 +101,10 @@ properties:
>>>>                - ufispace,ncplite-bmc
>>>>            - const: aspeed,ast2600
>>>>
>>>> +      - description: AST2700 based boards
>>>> +        items:
>>>> +          - enum:
>>>> +              - aspeed,ast2700-evb
>>>> +          - const: aspeed,ast2700
>>>> +
>>>>  additionalProperties: true
>>>
>>>
>>>
>>> This patchset is just corrupted. You already sent it as patch #1.
>>>
>>> Please run scripts/checkpatch.pl and fix reported warnings. Then
>>> please run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
>>> Some warnings can be ignored, especially from --strict run, but the
>>> code here looks like it needs a fix. Feel free to get in touch if the
>>> warning is not clear.
>> BTW, you already got here same comments before and this is third time you
>> send exactly the same without implementing what we asked you.
> Please check the following message.
> https://lore.kernel.org/lkml/PSAPR06MB494943F3F34881D23CEEBD9A897D2@PSAPR06MB4949.apcprd06.prod.outlook.com/
> 
> Or, how do you think what is better for me to add ast2700-evb?
Please stop responding just to make me go away.

Read the comments from half a year ago, which you have never implemented:

https://lore.kernel.org/lkml/e6cb6f26-fef2-49bc-ab25-fdc9a659f593@kernel.org/

On every new patch I was asking you to go back, but again you were
ignoring each of such messages.

Best regards,
Krzysztof

