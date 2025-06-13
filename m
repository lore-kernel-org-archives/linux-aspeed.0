Return-Path: <linux-aspeed+bounces-1419-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145DBC61CE8
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Jun 2025 00:57:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bJLZr5F7qz2xWc;
	Fri, 13 Jun 2025 10:57:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749776228;
	cv=none; b=i+QmzDOnsl7oKiELCZdZqrPC2XSDgPLyIdqkneIRuQiXkB0JCgpfmFrPm/TROLY89a/a6HTkgSm+9RZ9fFxIQvhDnVU2fMsS2zKBKSvJyiKYfzGZTQA+0u8HsKQ+3AXxM8TZAP4ceP+1WZb0BoSRNCbVCmKnuk/yYibe/cPObStYjCkdcgvCDtcS6bsoF6Ef353ESVNoOz7UlNLEx7W+NVC0/L3p43LakodVaIQhSBIGu2yejUD3wXniyaTRtYae06t00wamrJbeeJKz1PFT69Y9X8Fclq+CUQf685hMgHMV/OpdcwyzCC+/EaQnCN8OoP0g5aI/mH75iT9ZqZfjPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749776228; c=relaxed/relaxed;
	bh=rva0RzQIkUYUcYPpIJdvS6jyS8ngpfdISZUwpw5dy60=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m0YYDck4MrQRadbEiqrT8nK/rSC+guWoX46v0IKqEdjRXuDvxowNMo/q0vK3HyoKrU7/IDs2h33G8JeaCQG5HOLl84UkwpbG9E8Ugzk2eJc8cEi5+x9VpKulpafaWT7l2S9CJd2cxvwdnq/R74pWtxTefKeGsjOUGbTk47xbUU4+IHTfChLqvcuYNmIN7H7JKCR6+LzH2wF8kDzneth9l+IKSgaWAkQXDHyX/dKcQvZ9gZYbCJYj9Ccmgz0ypHslKAkJpdp+5RJ8dGyTF6E4V3/+RKCPDSFg++GVtXER5xQOvA4xOxaNCsOQI3LfvtP5Ey03yIq4Yts3Zl2UEJMo6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=GCUIthgL; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=GCUIthgL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bJLZr11Ctz2xKN
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Jun 2025 10:57:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1749776227;
	bh=rva0RzQIkUYUcYPpIJdvS6jyS8ngpfdISZUwpw5dy60=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=GCUIthgLYeq7D5761tx1yj+y8VqQXqv6qRWZ0/43kAIIjK7O84Ey9LDhbekpp4ryg
	 mq/1+2pumYSwArM5LUUK/8XkBEE3/1JDey9ckJup2qjEs/PAhHXvNgdPAMSnhZQkhi
	 go0PlroEhiksYOsUZS9wcnS1BHW93tfTIUAGnFdzZC8mtN9NVLCVq2VF9SUOdKacl/
	 LDPk1Zbmzsx2D1CqAurEfi6VtBpyh+2DPJ4EDgyRc38kDjdqcTGbgk21Zarttvr3td
	 j7WWOvId8CmjOJDonUn3+LMXWlK4xCUHtTfSXxkhI8lOXO3vFz1F1SVR4QOsbaar4s
	 WAbbR4ijK4j1A==
Received: from [192.168.68.112] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D9D746445B;
	Fri, 13 Jun 2025 08:57:06 +0800 (AWST)
Message-ID: <831a5bf06f6e7cd7dccce77d11209b5cc0f1387c.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 2/2] mailbox: aspeed: add mailbox driver for AST27XX
 series SoC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jammy Huang <jammy_huang@aspeedtech.com>, "jassisinghbrar@gmail.com"
 <jassisinghbrar@gmail.com>, "robh@kernel.org" <robh@kernel.org>, 
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>,  "joel@jms.id.au" <joel@jms.id.au>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Fri, 13 Jun 2025 10:27:06 +0930
In-Reply-To: <TYZPR06MB6568BA93BCEEBEE3B9DE15EBF177A@TYZPR06MB6568.apcprd06.prod.outlook.com>
References: <20250610091026.49724-1-jammy_huang@aspeedtech.com>
	 <20250610091026.49724-3-jammy_huang@aspeedtech.com>
	 <13b88c1e404a9abe5cfae6673cb93e0b020e3524.camel@codeconstruct.com.au>
	 <TYZPR06MB6568BA93BCEEBEE3B9DE15EBF177A@TYZPR06MB6568.apcprd06.prod.outlook.com>
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

On Fri, 2025-06-13 at 00:51 +0000, Jammy Huang wrote:
> Hello Andrew,
>=20
> You can find it in chapter of ast2700 datasheet below.
> =C2=A0 III Function Registers -> 12 Inter Processors Communication (IPC)

Great, thanks. The description in the memory space allocation table
doesn't match the chapter heading, which is what tripped me up
("InterProcessor Controller" vs "Inter Processors Communication").

Andrew

