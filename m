Return-Path: <linux-aspeed+bounces-13-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F62D2E015
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Oct 2024 06:15:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XYJgD3FVtz2yVb;
	Wed, 23 Oct 2024 17:15:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729664104;
	cv=none; b=mRQveE2kB2Wk2pKozdPdkz8oRecNUebs82OEJB24oh+3rBQvPDgxpecZtoYLicmmPJH2FMXY3vtc/Qv60mrLOx5ikmj3LuiG1PmrGAzPzz6EQ3pr9Lfjbbq2XdTDJ36leGXHi6Pa1B4fjR++EmdT3MmDyYv/b8SzbsgZRWRrdAYhcMhahzCNrFwCjZlVfXh/3pkRG+Y351U3cXv5tBFNQufavpgh/LP9Kwd5ctaACjCd4+8jZfNVuAzTkOJ2DIENyNjqGuaZgHV54wp6MrniTsp9+kU1H1S1Xgql2NyLKcvKy79qPv/sFQiMeW0ouDi62svX4xGOpSwwD5k0smNprQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729664104; c=relaxed/relaxed;
	bh=uPW4iOmh92n0FdWJ1U1PBgbj0zGgvRYGMjRMNUlwlTA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gaaW3kEXGBHFVmIP4EtqofWqG6kSUlh1bhx1v0x5FZoaGCsFW4OlW6mtcoaId8i5Qi8/d7r8zBfGtQ9RCtGTDjDVEdckXP7c2NM7bBofrxD6I84EiunAnc7MkrSUBBncBCrsw+5AxqMkAz6UsJWLpI1uOhYPpQv0nTpbq+D3IQp9V05Dgn3XnsaGH+sKh72krAIFKLOYlBNJ9LyWJ4ECZZsQaEDu8aBHNkfJsdObjLaQmYkdHMwJoGLC0Vx3zcGOq9bhUQ6yPHs81JXEjDcLL7urf7lzI52/Y1uwgWeEoka+1z7iZaKliNN/tRv/bRCocfiWlB8NQtxyR51RYGSfTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=X7iuuQmt; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=X7iuuQmt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XYJgB4sM3z2xfR
	for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Oct 2024 17:15:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1729664098;
	bh=uPW4iOmh92n0FdWJ1U1PBgbj0zGgvRYGMjRMNUlwlTA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X7iuuQmtFguQG+IJh+TWz3WceRdZtTv0UTTY3M8mvcCXfZEgzRTEnQbL4xosPwdjh
	 PdOeK8A1aYSHt2AN2kSU+h5erp2a53AwQqDkrUlvGVuKSRKnBBAOcEmjNnPb0U3e7x
	 WReBijoA0h92pnsWY2QEsY0Yxi744vJU+s+KbgVXaEcwhR6d71YPhR2G0Vu7Iktsae
	 A7Hyvyv8jd5I8B/ArQ/FWIqp53IwC7J+5bK+sMEPfF0gg79zVld4mGVlmNjgmN7BD7
	 xG1s96ZC2UTO32IzSGgLuVFFCdZkMrzGxvCldZYO+XMvsbeGquVnFMVYrEbpNa2ddt
	 ZoFkgx36BiABA==
Received: from [192.168.68.112] (ppp118-210-190-208.adl-adc-lon-bras34.tpg.internode.on.net [118.210.190.208])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DCEE069460;
	Wed, 23 Oct 2024 14:14:55 +0800 (AWST)
Message-ID: <de478e5f56bb67a9babe59afa6ad53c8dd4542ee.camel@codeconstruct.com.au>
Subject: Re: [PATCH 0/2] Add Meta(Facebook) Ventura BMC(AST2600)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jason-Hsu <jasonhell19@gmail.com>
Cc: yang.chen@quantatw.com, jerry.lin@quantatw.com, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, patrick@stwcx.xyz,
  devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 23 Oct 2024 16:44:55 +1030
In-Reply-To: <20241022021230.2322132-1-jasonhell19@gmail.com>
References: <20241022021230.2322132-1-jasonhell19@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0

On Tue, 2024-10-22 at 10:12 +0800, Jason-Hsu wrote:
> Add Linux device tree entry related to Meta(Facebook) Ventura specific
> devices connected to BMC(AST2600) SoC.
>=20
> Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>

What commands are you running to generate and send your patch series?

The patches must be threaded properly.

`git send-email` or `b4` both do what is expected without any effort
required. Please consider using them, particularly b4, if you're not
already.

Andrew

