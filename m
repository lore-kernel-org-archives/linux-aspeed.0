Return-Path: <linux-aspeed+bounces-2332-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942D5CAC5AC
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Sep 2025 02:17:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cWgTT5hXQz302b;
	Wed, 24 Sep 2025 12:17:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758680221;
	cv=none; b=aY8wp+ozQjWaFc9wkL+XreCdTn6i+0kvj9kSogl3hHWSEKHSgNy1IgS/37MeEXx/HHBwbCQ6cRL9SXGfNW2g1PaPaWpYVBp+4wM/IKJfQu/LYu78mDmJRl8WBN2Tzn32ua34Wrjt7m4/hfiWa/pR6m7Ae9Th1wgnOkmxqHCe2kmhazlK2l22/lTjFUzAcNl5GrKB6lBHt1uDBQMgTotY7hulp7Ua/qy7BgBANCf3EA8CtPDEGb6cuX+HOmwX4pgpOP6EsuZX4ePIqfhzbgkA+Ts0vLP0qy3Fb/2JivINi6TWHfohSqnMzlC5Xcr8ooH/6UCMPIXNudHxxHcasKz2RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758680221; c=relaxed/relaxed;
	bh=o86uR5LMiT+hV3SmPRKcbqfcrdavxLeiGsYGrCWjtn8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=idpR7e/aE/M0pqjkkaGC8i8J4DRiM5f4Xq3mElLRHPLg4n1XK3fIZUswtdqTIlVgtOAaeRVzNAtj7Xz5chLNDMku0LAq1MFyNuIzVxikfTcXb78kQoEYy1NKUsWIx6DikxJBjbPbnqDZqyyyqGzDQOC08dlYdDcUOobIAo6Y2RcxddLgzwE8KVf26GATAlplkvz7S88sxC5+mWSoI8t//HL5jl8t8OLlAxISOrZMQA58Ks+gdIIYfqpmUG9TaZV2QuwyLThpc1iBi4lmhCsk8KkuX9T/rKMq5e5B7ZnO887atgh6iiBSucSxFDjkzLsZOFzekn3Uoa5LdTuiVHsKjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=NVcwZUij; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=NVcwZUij;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cWgTT2CfQz2xcG
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Sep 2025 12:17:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1758680220;
	bh=o86uR5LMiT+hV3SmPRKcbqfcrdavxLeiGsYGrCWjtn8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NVcwZUijQuewnTTWXH/HwuKOdQOniu3CnCeSgCJS6CEOQdhRR2PPy7tf9fRR67doi
	 XXQXHzDxe4GRVIpHwCHPDFv5DzG+iWdc7uq31HePz1HYcvL9cPNPLk23l9MaNOYCFN
	 wE2eNwdy8haEZg/qXh9A2ycJxMU3Cc6unjBtvcPWXj5GjxVKLRrcwEcVnlzsLghDst
	 UyS1EGdqx1uhBmy6U27hJojdDzDLyRZcSaqULHrcAQvUfbKkXXna81PnFCkKiSvn6p
	 NVopGc6QrmO5anbsh9s/AbKUI7U9Lm+vWtsy8E5nU58Vc5WWnGVOV4+vWU/vx22JxH
	 1if9cC6lDKt+g==
Received: from [IPv6:2405:6e00:243d:a853:dbe5:4849:b82e:5665] (unknown [120.20.205.123])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 15EAC647A7;
	Wed, 24 Sep 2025 10:16:56 +0800 (AWST)
Message-ID: <e970c1693af3a612d9eccac2932e2e0be3d37453.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] ARM: dts: aspeed: clemente: add MCTP over I2C support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Leo Wang <leo.jt.wang@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
	leo.jt.wang@fii-foxconn.com
Date: Wed, 24 Sep 2025 11:46:55 +0930
In-Reply-To: <20250922-leo-dts-transceiver-v2-1-d2dc0e24a70b@fii-foxconn.com>
References: <20250922-leo-dts-transceiver-v2-1-d2dc0e24a70b@fii-foxconn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
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

Hi Leo,

On Mon, 2025-09-22 at 15:02 +0800, Leo Wang wrote:
> From: Leo Wang <leo.jt.wang@gmail.com>
>=20
> Enable MCTP communication on the Meta Clemente BMC board:
>=20
> - Add an MCTP I2C controller node at address 0x10 on I2C0
> - Mark selected I2C mux channels as MCTP controllers
> - Remove unused "i2c-mux-idle-disconnect" properties
>=20
> This allows MCTP devices to be discovered and used for
> management communication on the Clemente platform.
>=20
> Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
> ---
> Please consider the patch "[PATCH v1 1/1] ARM: dts: aspeed: clemente: add=
 MCTP over I2C support"
> withdrawn.
>=20
> After further review we determined that enabling MCTP in the Clemente dev=
ice-tree is not
> required; the affected devices are managed through other mechanisms and a=
dding MCTP nodes
> would be unnecessary. To avoid confusion and noise, please ignore the pre=
vious patch.
>=20
> Original patch message-id: <20250918-leo-dts-transceiver-v1-1-3e2580325ed=
c@gmail.com>
> ---
> Changes in v2:
> - Withdraw patch; no functional changes
> - Link to v1: https://lore.kernel.org/r/20250918-leo-dts-transceiver-v1-1=
-3e2580325edc@gmail.com
> ---

Please do not post a new revision of a series to announce withdrawal of
the series.

Rather, reply to the original series saying as much.

Thanks.

Andrew

