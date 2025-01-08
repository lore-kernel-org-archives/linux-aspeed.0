Return-Path: <linux-aspeed+bounces-349-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0924BE77197
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jan 2025 00:38:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSTY72DG9z305P;
	Wed,  8 Jan 2025 11:38:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736296699;
	cv=none; b=mzs9Ilik53tKH4VIzEPs0FnAYnf6z6Vc8CmS1tKd2Z8PIQEMfbWG46scgY+KTuuA+05Box6uBHkol2q0UjVfWuz8gDftHR0HgG+khmWrMPDdH7xKtUHW+ihStNpgljuCxXNzXWRAyH1V03K/RRusMzNs297/XctH+qJjHMRTyYw5R/ypg5eT73V9MpCZxxH20GDPO3E/LfcG8a+rHRYQdbhPdI7nsyCpNWJ29jiV3xGVOCfjjBTsO9tkVgeno7XYdgmcIydG/WKCRHmuB7O1LCap+rAB8qRsYkM8OZHR93PiOaRLmFypjtu5sAx0dWD+VlDP+/O/blpOnG8kqmGnvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736296699; c=relaxed/relaxed;
	bh=iJL0PVWacK+xGubdB8yj8Qufnec/nGx/Vtx+xf0kBaE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lwo7PMneB4XcnKE3Rnkn3R1Q26mCz99IXg+j1T9hfL1oIbXSJyA89E9jZmcjxWHNv1c3Fj9dzUFl125L9qFE0CrLybgXsR3XCYc2VhteI1EC5qzlObi3xJp5wzk/MFnV7/MfqQ7u3NZWBddSd0tHCCejwqN50neLBt/PDnU/BFUJY8Ecu8+4yIZbMpZav+Td8roguyKWC6meWJvJqvedUwL7/iN06bdTcNmYgh6fSCP/OlL6D2nIPom8eosMBvfC8Fap3dMw0fkMuCeBmcOzKS2d8GRyu+wdQTawv2n1F4Gt8NElery7qqUTrNn6sxGrPFLluyYQ7qhF5b7KM3m54A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Ss4Pa9yA; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Ss4Pa9yA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSTY60bJrz3055
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Jan 2025 11:38:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1736296697;
	bh=iJL0PVWacK+xGubdB8yj8Qufnec/nGx/Vtx+xf0kBaE=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=Ss4Pa9yAg+I0HqIcKHvJe+cy/0dMiwco2Svs0rc4Opbo20D9bjGWBPDN05vZAelEa
	 jrqGK0WVwuNuORPVUrkZtXgzuVEb3iXrfk1HpFcIzmZT81Rq45P8CAO0Wyh2h76ZeL
	 rfC6iatuQuUFTQr405VBoTrgTkACXqSJYP9jGmjYJoxfINUzqJSLgLMdS3TFdgRhg4
	 KJ+bIvn9r0JSKGT8bCt0PIbaJK+8wO2ib4cJ0O20Z6J5v7CeWUhq3WssZjOJHOXS/P
	 gA1hgZRrtnhvKv+vPl52l75USr2KmgTWWEzzYJcWR4qe/CtVVGBrNZ6kTc+UZlFJBp
	 FFfxprNQ+HW4A==
Received: from [192.168.68.112] (ppp118-210-64-24.adl-adc-lon-bras32.tpg.internode.on.net [118.210.64.24])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 96B7E70B92;
	Wed,  8 Jan 2025 08:38:16 +0800 (AWST)
Message-ID: <f7619bff61f400faa2174e8a861916ce4f68c4b4.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Correct indentation
 and style in DTS example
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Thomas Gleixner
 <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org
Date: Wed, 08 Jan 2025 11:08:15 +1030
In-Reply-To: <20250107131108.246898-1-krzysztof.kozlowski@linaro.org>
References: <20250107131108.246898-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

On Tue, 2025-01-07 at 14:11 +0100, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces
> and
> aligned with opening '- |', so correct any differences like 3-spaces
> or
> mixtures 2- and 4-spaces in one binding.
>=20
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> =C2=A0.../aspeed,ast2400-vic.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 =
+++----

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au> # aspeed,ast2400-vic=
.yaml

Cheers,

Andrew

