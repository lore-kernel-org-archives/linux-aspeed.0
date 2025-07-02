Return-Path: <linux-aspeed+bounces-1607-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB9AC7EE30
	for <linux-aspeed@archiver.kernel.org>; Wed,  2 Jul 2025 01:49:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bX2rs0PvKz30FR;
	Wed,  2 Jul 2025 11:49:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2404:9400:2221:ea00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751420988;
	cv=none; b=GLcSvDCAcny4+7LjX715m9ckuOdNSItrWBwaqGcZ7lQmJzR1rPhyghlXcQlxJu0XYkYqGOIu6WN1FavZJAcj24r0Fb/bWFBpeSiPtSgJ1O8vFAmj1gDe21Id/n0pMMiBbUJbjDph4LBWyQ0E/6Q0zFVCAicWCKgtLCWFHY5zNxYDVfzfoe1xUFDRVL1nEuxQBBC+S+737SJnrUNUKtfE+K1BWDmi1dF7Po/4URZncYzyEfwGjFCOBcHkAMraI5mCa6xYXMbh07qKnuU9j5ngG5Xv9cMmFbXiADY8gB/RSejxmMNWYfv033vDetYZ5FTvAQVNCp4xcZ8MhscGghbj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751420988; c=relaxed/relaxed;
	bh=VXy2MXucUAwAMgC5dNJmBFgEBpE/G+rOGr+3LXVk6aI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAfqtnN32zNe4TimHCHZw9sTtI7v+3H6NO0nVKjFoVOcIbEw2T6XZ1vau5NsiSxR8gKHlT66hxVV4hJ94ifmgfaoUxKfyAWOSWUC/XYB2Tc4EqGQ4eclQhQb9PuX+9OwXXz+sPgc573bvdgujv+dY+eT4BrBBxiEcCaytltWKVRf+cLxSemEX5FI98Hk9Hqc/AqaqQYhXcb0NWTw6bc7bR0zwarQHwvfsS9zUVEZJI5ZvPmy84nOahHQfLjLqOMrnHLE/sgJCCepPNHci49thmPxfiOADek6u7o/jnoIeykOpdFBfxFh9r9AZbCLEgHxwKkWmIS+9cXmUoTDlfSfFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; dkim=pass (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.a=rsa-sha256 header.s=202503 header.b=iXCwWXhA; dkim-atps=neutral; spf=pass (client-ip=2404:9400:2221:ea00::3; helo=mail.ozlabs.org; envelope-from=sfr@canb.auug.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.a=rsa-sha256 header.s=202503 header.b=iXCwWXhA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canb.auug.org.au (client-ip=2404:9400:2221:ea00::3; helo=mail.ozlabs.org; envelope-from=sfr@canb.auug.org.au; receiver=lists.ozlabs.org)
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bX2rp4RBLz2ypV;
	Wed,  2 Jul 2025 11:49:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1751420970;
	bh=VXy2MXucUAwAMgC5dNJmBFgEBpE/G+rOGr+3LXVk6aI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iXCwWXhAX7kvp+WmecSmDvMABSElLwxyLBGeKfv2dDg1Gcgpfj5hKrSnmws6ZLb1R
	 DABcqEU0X7HWj/7ljISDwX0L5ZCQnOGNdM3C9FjhbVREbzawRplseisvHGhBEEroBN
	 QJzxvUWj2UNlZns1FvY8CVwUs7vXTi8vvTWBAafQRd7qVQbJpILrKtllUu7jqeKJf9
	 7gNYgrYkn91JxlEENNexeNZ2ALl920WNEwNikaLvF8ZFhp57LIOzm9mxDbtptBT+N1
	 aWVBT2VI1buaPvqQXHxKdYIY/N2FR2/Yy9rcdxUbL5P3z8F8gqIQJgJMLAjVRbJBPn
	 lbHYYp+9BsI3w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4bX2rT6Qxqz4wcZ;
	Wed,  2 Jul 2025 11:49:29 +1000 (AEST)
Date: Wed, 2 Jul 2025 11:49:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-next@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org
Subject: Re: Add bmc/linux for-next to linux-next
Message-ID: <20250702114941.5bfe1e5a@canb.auug.org.au>
In-Reply-To: <2ae27beb3fa9266e8f73cfa10d8299465d872183.camel@codeconstruct.com.au>
References: <2ae27beb3fa9266e8f73cfa10d8299465d872183.camel@codeconstruct.com.au>
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
Content-Type: multipart/signed; boundary="Sig_/olnj4gvN==N6hy44f10+yNA";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/olnj4gvN==N6hy44f10+yNA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, 02 Jul 2025 11:01:54 +0930 Andrew Jeffery <andrew@codeconstruct.com=
.au> wrote:
>
> Could you add the following to linux-next?
>=20
>    Repo: https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git
>    Branch: for-next
>=20
> This aligns with the recent patch to MAINTAINERS for the ASPEED tree:
>=20
> https://lore.kernel.org/all/20250702-bmc-tree-update-v1-1-c270cd8af0ab@co=
deconstruct.com.au/

So, does this replace the aspeed tree
(git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git branch
for-next)?  Or sit along side it?

Either way, who should be the contact(s) for this tree?

--=20
Cheers,
Stephen Rothwell

--Sig_/olnj4gvN==N6hy44f10+yNA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmhkkDUACgkQAVBC80lX
0GxEeAf9GBf7tmaV5IVqLypKCi0Vd0YU0OiupwyekgLXR6FnI/jA2pB5AbHCe5mt
sKYyqctFxEMqPaS3x5GZXHMea/kJ899u+RbkhQNUwGHIf94SJfkhatNbvDveAZzD
LfQWG8VIwar6MCP/wH8LH4q10lMRaZPGHTf//iLr+rSPyhOKCTmXYEh3IhWa55ZF
pEQ7TeOyXnd0PZIKcTmpuq95fKJyV9UX5W08XXHC4crCLitT1mNA4ydgwwpS+eRk
WEr2keM3r/9RyShdN02dTkgzH2b/YJ8X1LjSMJyM/o3EjNbuv7+CcZQlgK8Flo4B
0Jf0++FNkD8ktwVo1JPp4Ir+815Cbw==
=pNgw
-----END PGP SIGNATURE-----

--Sig_/olnj4gvN==N6hy44f10+yNA--

