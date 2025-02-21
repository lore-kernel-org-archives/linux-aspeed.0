Return-Path: <linux-aspeed+bounces-800-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94731C021B2
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Feb 2025 02:51:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YzZR10WWjz30T1;
	Fri, 21 Feb 2025 13:51:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740106317;
	cv=none; b=EnzayDClMHS4LCY3RTGpu1Y8aajOPJ79GeUEIzX7IUwSP/d1CPLbR5b1tFwCKACU+VgGPZ0BRBYrq7bvZaQiFDJLzolPKb0l7U7KcpBU+Sx6KYmJlzgex5G7/aUfv+BnfqQksbLx9fTMiGc0KHlBuuxXRN7XdLWSfeHUNXUZrU3KIkWi6CzGlQDVEm6HT+TLvCdQP45ruTW+COuNW60zZBEuLFrhUAo5ebcPTBcCKft7OoJzGHli4sH15L1RkD4hyGYpDFv1HFv+oEGJMpkfZmm5ZAHPM/0DQ968spDb4U9o9gb3E9tHpBzBGP9JlPznZ1I0yozw/Tg8Bm+J/Drggw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740106317; c=relaxed/relaxed;
	bh=UnJlIFv0UPUzNd+Vm3edQcV3c4YlHIanESgLP3djvo0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kdezbGpNBt3PpAJ8cn/YE8a7QV1lKc76kithMtd0ao4auJzJuzdEB1Mwpto+K2Ip300alWMyo7vV7QC7jojr5BT4mn8+RxybpUF6PZROnaaB+vystyCYlKOcqvnEZnR8rso8uutR0zY+9MCXYVzYSqRWF0SPzA3/8nqDGTyOMvBUfV+e66PeRTcBjHBrsFdT+okR85uSk/UJVkgCyM6EJ7EYtdfzRhZV8FxSqVL7eCDgoM2EZrBqDqRJBl66x7ZMEMnvNxipvghBrT8Wssif+oM4yVQY+c9PIMz9/ri+9xkrtW3Cw9F3h2uLTDfVzkCAJqsoD4F//YJWuzySsDu/vw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=heDSOgdi; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=heDSOgdi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YzZR03qrTz2yyR
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Feb 2025 13:51:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1740106316;
	bh=UnJlIFv0UPUzNd+Vm3edQcV3c4YlHIanESgLP3djvo0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=heDSOgdi2Y2Q3C6UtY3/RAZCOylprvSdvWWTv++IwVftSMht359YMj0lw/EZgpu5q
	 SpjrKtHOF5jhW2BZRvEk9FFYcfAgB0BDK6dLYghRL1inDTJgKq51bYpQ4hpPiAjlXI
	 7Cr44g/wIl3uA5GQWTw3TudE8FTG5WKmqTb/mR1v3POlp11pORfFNcSOxqKkvuAYUh
	 SqHMdAy49SJsvStLIiLOSagIrA4IWXlWQE1i3R6mQljqEJWI9HG5DR/DOSCuJhkSNI
	 NLS7xNtFlR9QOlehyStYuHx3maYm0TBdxYzLjbfLTZfbWowRjVSBvKATI7eoPpSZrU
	 EKPeciMa5yRBA==
Received: from [192.168.53.88] (ppp118-210-81-188.adl-adc-lon-bras32.tpg.internode.on.net [118.210.81.188])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0E0C276B4D;
	Fri, 21 Feb 2025 10:51:54 +0800 (AWST)
Message-ID: <a8fec7b5a84cee03602d4bca6c3a12d81fb141f4.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5] ARM: dts: aspeed: yosemite4: add I3C config in DTS
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <delphine_cc_chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Fri, 21 Feb 2025 13:21:54 +1030
In-Reply-To: <20250220023233.1686419-1-delphine_cc_chiu@wiwynn.com>
References: <20250220023233.1686419-1-delphine_cc_chiu@wiwynn.com>
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

Hi,

On Thu, 2025-02-20 at 10:32 +0800, Delphine CC Chiu wrote:
> From: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>

Typically git's user.name config should reflect your well-known name
(with spaces between your individual names, and without e.g. a -wiwynn
suffix).

>=20
> Set I3C config in yosemite4 DTS.
>=20
> Test plan:
> Tested PLDM GetTID successfully with the I3C hub driver.

How was this successful? Your patch fails to build on top of v6.14-rc1.

Please make sure you're testing against an upstream kernel tree.

Andrew

