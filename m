Return-Path: <linux-aspeed+bounces-1895-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03217C87FCA
	for <linux-aspeed@archiver.kernel.org>; Mon,  4 Aug 2025 01:38:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bwK2h0WT0z30RK;
	Mon,  4 Aug 2025 11:38:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754271516;
	cv=none; b=fxsSHSO+NK9t+bdVDDS6ux0SL4ic89GkqAgzNJuAzZKsW4Iex3zpOlnojNQ/Wv4kKpND4Hr5zPbUOF33a86fRI24bfilqKMHctSpx2wnC1Sy83x/tWuXjTY35FZ6SSZfTze4C8ZMjoD6DJd+I7rc0vSoJdOwoQxdEu4ZEyGwLPenorqm0SVA474Z1xXr9JpavH2pE45yk/aJYIwTdSl4fZNP+WYxh3R6KgB9k5gPbQxDSrX/v4WE8PTqmLqW2oGT/llaDj9YP/3BS5Q26kcZnEMYlF4l49Nlon8tPmoOWPWZMfFH3E/zJQ7dFvjZhL66k1mb8HD+zTvqR6qGkunEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754271516; c=relaxed/relaxed;
	bh=K0fmX2jpwV/gvmwq7SFAn/6INWSi5gMMueD8SBA981g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RvYoJy5Ow1C0Wfa9wLW6/HLPUIybwiNUa6t0Mlk/fUwLo7rbM00cD+vn0jbftTq8wOgLK9mmc0QVvfSRSp+Vy6Fllf+Wo7rRMfIV4+NTevQVxCT5vyD0lV8lS6FPyFRs7pxYgir9Gu5G+jUoqGo8Z2vl947romrtawaT8r1pAFuHLYUUUlH+ATE8TBAMwUBfoFnce0IqE1Vgfdo2OdkbTuM3I9j/CH18AD6f7CqSp3FOlpKFbxPlFypmpPBBmhvl5IduMggx7fb5GQTi22ThLgPn/bim2kaH7Maos5I5H+Ocevx2LrP+PKUGsBSBe+t2s41DkYRIRh03BPK8ary4/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=IoCV9S6H; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=IoCV9S6H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bwK2g1f2Kz2xlL
	for <linux-aspeed@lists.ozlabs.org>; Mon,  4 Aug 2025 11:38:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1754271513;
	bh=K0fmX2jpwV/gvmwq7SFAn/6INWSi5gMMueD8SBA981g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IoCV9S6HbSiiB7Te0cgkRtVTIjvsS7DCtdWqbWirzzDtD9Iic3sT/pwyTHnauvshR
	 Bijw02uFdbBL9sDjji/iyVbfexp5n1r9EzLdfYwN3ofVi5zeXNknYPBXPxUKoYsMcQ
	 rehrpPgqkK3P63R0kOGrYecXI93nHTA0y0RY0MP/4eUeG98CPuaB+KsJeOm6oOaYgg
	 lE3Lg0bTnSLPnRFmmE+GCzf4y24t0nX9/FkOd9rQQIYkkBmFrgbuHXcTiENtxamUUZ
	 NJgv3eqNxqKR6SkTgh0VBdSFtMD/TCJlUSeLqk4tuHwl2QpDU5sPdOqcHq+x2mEbeG
	 gpi5U6yV2zbxQ==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id CD4BD67B49;
	Mon,  4 Aug 2025 09:38:31 +0800 (AWST)
Message-ID: <1afcfa0244bb2ad184fac49145fe6856b257c5af.camel@codeconstruct.com.au>
Subject: Re: [PATCH 0/6] ASpeed FSI DT clean-ups
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Eddie
	James <eajames@linux.ibm.com>, Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org
Date: Mon, 04 Aug 2025 11:08:30 +0930
In-Reply-To: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
References: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
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
Precedence: list
MIME-Version: 1.0

Hi Rob,

On Thu, 2025-07-31 at 17:12 -0500, Rob Herring (Arm) wrote:
> There's a whole bunch of FSI related DT warnings on ASpeed platforms.
> This series fixes most of them except some related to SBEFIFO.
>=20
> The remaining SBEFIFO warnings are from some deprecated properties noted=
=20
> with 'remove when userspace is fixed'. Not sure if they can be removed=
=20
> now or soon. If not, perhaps the deprecated properties need to be=20
> properly documented.
>=20
> All the patches here are independent, so DTS changes can go via ASpeed=
=20
> tree and FSI bindings via FSI tree (or ack if you want me to take the
> bindings instead).
>=20
> Rob
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Rob Herring (Arm) (6):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM: dts: aspeed: Drop "no-gpio-delays"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM: dts: aspeed: Drop "fsi-master" compat=
ibles
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM: dts: aspeed: Add missing "ibm,spi-fsi=
" compatibles

Thanks for this. I've applied patches 1-3 to the BMC tree. I'll leave
the binding changes for you to take as indicated by Eddie in his
response on patch 1.

Andrew

