Return-Path: <linux-aspeed+bounces-1032-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64612C282EC
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Mar 2025 01:33:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGvWR6QV4z2yVb;
	Tue, 18 Mar 2025 12:33:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742261635;
	cv=none; b=KSt/xCsVEpRdWXjSeVQ4yJMdwH2zWoCW3O7m+C0UR8wlZM1qb2v6LNyIB90elKZGdwN7ggiIe9ou4VLXpuBnhmtfMGyyVgiDu0yzkq7uU1u+DoJaJbPfOkYTS54bAt1gLKLEdLIJ+pNF92dy0pTAo4kfDPnDydMbZr+F1wrYeinj2ampXNC5rbMBZ+vt4l7fMt7j4BizSvnJ5r/bLY3i9REV8w9qyZO2Qo5+pu/oraygMO5I6/nWCxmpIClgcOwINByKN6E6GJbgMO7UZ3Kf+8mK2aDYStMt0gG6n+K71YCWXjRedjERDERSQqTpkmp+zDECPLYHDsyTbLVIyDD/5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742261635; c=relaxed/relaxed;
	bh=PoRoAAkPPBuR69LGmDgJzLuMGmZ8psP041boRYo8zvU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HVQDW+fgWrarOgHN2D3RbDMEkDBOe8v1jwgfgGxgbMot++nW3CWvTOgA60Gx/q4pHS3oaThCe8heISraEF8yF0qkj9JO4CFjOarZHVYmuyYa60ycMHafF4KJsrQuaa4nb9MjnLr7Q+KkPY5vVsjtF10YAtWehmlrVZc1IYT0Y7vNXeVlVy8v33X4TpoZNFLSkDBkIAVnH6Neb/3nh7PeOkz7XFUSEBgnFWnF2ddr5OI5yHq2EM/DcaeRcgSTRdRsHuU/xL654QtiTU9hKN/SNT04p4kQCxs/5YGqnZLt20TVi1iJawiCbsxV7WsEe/t2e0ijoKvE0HztUpCs9d3WCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RgpdrTVA; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RgpdrTVA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGvWQ4NW0z2yS4
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Mar 2025 12:33:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1742261633;
	bh=PoRoAAkPPBuR69LGmDgJzLuMGmZ8psP041boRYo8zvU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RgpdrTVAI0X/Bp7kAD0o3uQI+apgWXfXXglB+hBR8dgCNRQIG6CdgyvUrhjOjEnjg
	 9GdgnsQjosBOqJXz71WW3TgrVmdWnOIL48yhskDwK6idlAH/Y7IddHuo2smrcbVndQ
	 5kYYjX5+fZ3Js/lGbtH+LEHjGFeC6im5tuF7N6OSxvwS2ziPZkRe++0I4HW/Jiut6v
	 jOn3do/4O5CrQbkAfJlOnz2osaT0Ydh2EuWACE1uC2rTdLan8nrTpLG4oOiYfFkCsU
	 ZyqNxihU56U4b+PxXCThwfFDNON3zegoknyvxpj00jQwtQRBIr/clfN3MVcSpf/OvJ
	 GqqvwjTghX33w==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D6A6777BB4;
	Tue, 18 Mar 2025 09:33:51 +0800 (AWST)
Message-ID: <57f42b7d08b816bc1a2e25d7f5932c3b2166c074.camel@codeconstruct.com.au>
Subject: Re: [PATCH] usb: gadget: aspeed: Add NULL pointer check in
 ast_vhub_init_dev()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Chenyuan Yang <chenyuan0y@gmail.com>, gregkh@linuxfoundation.org, 
	joel@jms.id.au
Cc: linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Date: Tue, 18 Mar 2025 12:03:51 +1030
In-Reply-To: <20250311012705.1233829-1-chenyuan0y@gmail.com>
References: <20250311012705.1233829-1-chenyuan0y@gmail.com>
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

On Mon, 2025-03-10 at 20:27 -0500, Chenyuan Yang wrote:
> The variable d->name, returned by devm_kasprintf(), could be NULL.
> A pointer check is added to prevent potential NULL pointer
> dereference.
> This is similar to the fix in commit 3027e7b15b02
> ("ice: Fix some null pointer dereference issues in ice_ptp.c").
>=20
> This issue is found by our static analysis tool

Which tool is this? Can it be run by others (me)?

>=20
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

