Return-Path: <linux-aspeed+bounces-4541-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25E8C44536
	for <linux-aspeed@archiver.kernel.org>; Thu, 23 Jul 2026 00:56:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5CNw11npz2y32;
	Thu, 23 Jul 2026 10:56:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784768176;
	cv=none; b=c8fsBBOikjbPZoW4D0ZkM69/QWcCLJbp7ppfXEx/IZM+CWQVi8tUiC0uE0GmE3AhcBv/FmY8KLBjOWVkdzTdSefpUwndPeHlzltA1j++XFOL1e30fJLmbqS0egBUdUKMqpe1ISHNG/42ubabUUibDAClf+bnPTDe/cp9nnire4PcASnp2OSE9gRP+K+NRozJxKejfmeZOhvhZjlkSTz0mhcKL37v/ruRZdwZsAhHYjbZaRcQFh89ST72Hh2RNqxcvnQpW2DqN3oPIwWTYh1daS9f1l4IevAfRrM+J3AE5q6Aa5W9YOqaqLsI8mO57VNFlWXL893/+afqd/k4SOnbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784768176; c=relaxed/relaxed;
	bh=mgACCFKq2MK0Ux+A6DgXlsBhoMpXNtQXtj6PSE1bTeo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=myilmxc4HNr6oOX+2JeF4aFXevgtWIFPGNV0QZu+bwM4t3hPZgk1BvhFdrqtlathj6SsT4n7fbm8toIYJVbrbNw3a//f7ICLu3918NB6s7w2o+OuG9NGI+rKYrDVn9GheQp6gjcWMJmkw867wwSjH1nSZ7/CNH+GY/MpaojEb14nPZIxSckAH2FPxXFBdRtLghoISUALHYA94j1TmM/dv642KxMOxeVTlm8MM/mhHIMZ7Yeh53No92CmWsrnW6MPYZZsM5zNOYBJPsx7L28BmOWTuhDt5VaJ5IeHkorSKlW7yajWExmeLZCp9z+YFsf+RUUY+VeriqS4QkiPEfKGrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=KB86zf9d; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=KB86zf9d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5CNt2VK1z2xfB
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jul 2026 10:56:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784768171;
	bh=mgACCFKq2MK0Ux+A6DgXlsBhoMpXNtQXtj6PSE1bTeo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KB86zf9d2WLK0LIcEJVmon6M9h3+R9wt5qyRbJsDN3s3UOE3j0omLV8x7wUMCcSzE
	 /A9iNxgcqW8ddJf5sz6NrpO3ZXaNlEkh6rYy/wBegtezNxfcKRa5ldg/SqFC1sk2ws
	 hi15HF+D8qN1jKbKM1CudigiTnrLXkN+gCQ1++kuXeHJ4ZynOb36Ko4Bn9P0WaqQwY
	 yd9Rpw5gTYbafvXpQRpTj9a3ygpt6jVhGbp94DZEQqceT2GWFcYAtKGLkwviKpOWHx
	 yQq2fRqmmdlcG/agN4xWkF1+p4L1LRWsD6CtlRCtVhe/iHHl0QH5ysCVAJ26nPAQeE
	 fu3Jmi5RO73sQ==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8EA60662E1;
	Thu, 23 Jul 2026 08:56:10 +0800 (AWST)
Message-ID: <71d33890fe1940b7e4f8f275233d4fe9d8791da7.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1] ARM: dts: aspeed: g6: Use KCS AST2600 compatible
 string
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Haiyue Wang <haiyuewa@163.com>, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 "moderated list:ARM/ASPEED MACHINE SUPPORT"
 <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/ASPEED MACHINE
 SUPPORT"	 <linux-aspeed@lists.ozlabs.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Thu, 23 Jul 2026 10:26:09 +0930
In-Reply-To: <c85229c4-2c9c-4231-b294-e8012c3fead6@163.com>
References: <20260627052708.172918-1-haiyuewa@163.com>
	 <5333a3912656d4c85fd063dc5726106e38150ad6.camel@codeconstruct.com.au>
	 <c85229c4-2c9c-4231-b294-e8012c3fead6@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

On Wed, 2026-07-22 at 21:07 +0800, Haiyue Wang wrote:
>=20
>=20
> On 7/22/2026 8:55 PM, Andrew Jeffery wrote:
> > On Sat, 2026-06-27 at 13:27 +0800, Haiyue Wang wrote:
> > > As the commit 2596f6b93a60 ("ipmi: kcs: aspeed: Add AST2600 compatibl=
e
> > > string") does, change the AST2600 DTS file to use kcs ast2600 compati=
ble
> > > string.
> >=20
> > Is there some other motivation? It's been a while, why now?
> >=20
>=20
> Just happened to see 'ast2500' when adding other nodes in DTS. Nothing=
=20
> special.
>=20

Okay. I prefer to leave it as is until we have a functional concern
that motivates changing it.

Andrew

