Return-Path: <linux-aspeed+bounces-4095-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF067CD5BA6
	for <linux-aspeed@archiver.kernel.org>; Tue, 19 May 2026 13:11:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKZmh4w4Wz2xwH;
	Tue, 19 May 2026 23:11:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779196260;
	cv=none; b=XQUyqUvaPMib3wPODkaBuB5FDrix72z+smBUiUpp6nF6Xf5IYTsp55NX5vejsnLiyqNQLIbExgQa/rPI79v8LUOqTJz8E3UhnZzVXDonauNdbH3juHaRDqw6wWgFcXpxpUVnzMPpUd0FUFwvfIVdq96QgRppNBxTca5u0sHuBLdYn4wBRyecAYECWJxxwaHuvgWwWuSlC2zyPd7d4HFeb4B2lvS3Xe3PsoPUr/e5a3jc4abAUZSdzTqMMSjqyr6lnzSTqXM+00aQ1sgW/OBwbioOUYeJIsHKt33geFYPZl8c045d9hF6eY1W6mT55po8+Ar39394UnEoYKZ2Ew1Lfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779196260; c=relaxed/relaxed;
	bh=razt78RJ4CTL26eCw5dWKM6IJ/SOe1x3c5Yxz0/SgCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsyN255pi1AZak6nlKWGonWkepVmD4dv9aDRslB0fclUqLtmB+aV8P+OcuP/KYqU+Khd1SUiyjv5FKADKIYmXrc8DllqTnPZfWd4r5lH9ltl0appp5+oNFes9q0CpRQNZbbe9KNOxeByHBQdpukOeld7SMZvq6TYHArmGlYbvLzPrrHT/N04TYJQpSVTQF+r0alCXxYQ8jOO9BOlEHUjEMStw9E9lq5NKwBexhPQoFTkddDqCqiGsdf+FksbKMHSNBb3CJEzpMso22tVja9pc5p4vAIddru94X2Jd1hVtTUbtRcQF5rlrb5VQZPt4d2ZL6LuwcqFkRXKHtOWNzeoTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JOdOU3mF; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JOdOU3mF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKZmg3qYBz2xqv;
	Tue, 19 May 2026 23:10:59 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 719E96020B;
	Tue, 19 May 2026 13:10:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CC5C2BCC9;
	Tue, 19 May 2026 13:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779196257;
	bh=razt78RJ4CTL26eCw5dWKM6IJ/SOe1x3c5Yxz0/SgCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JOdOU3mF0sL7xT9C/z85WgNKLpQ6jxiWj/zrLPnjXE8vjCaajzt63MSOQk1mpVBIj
	 lJGOiHHut9Oc2tI0SVHGtBN/6dxZIRBkYk8nBZ1WgysCnvjQZPwgYUswJjcY2LM/Xz
	 ciKDoWr6lGGLBJHGUUeqlH7ACcqL5QBWyWsjkvvPbNXkOI/ZFB7Kq8+WnLdsX7Da+0
	 f7kyWjVWcallJ6dmv4bZDU4XIE81J/IB2u+sU/OeMSFtl07xR7De0Ig55m70O/mONu
	 PEwgHDCmFIRAqt5MREHm1y3dvCaal1Tee74/JycPIDCy3NkCD+ytI5ydh4JolP6Uhf
	 +wRBbipOgSAzQ==
Date: Tue, 19 May 2026 14:10:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc: "clg@kaod.org" <clg@kaod.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	BMC-SW <BMC-SW@aspeedtech.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] spi: aspeed: Replace VLA parameter with flat pointer in
 calibration helper
Message-ID: <4efedd52-7b88-4b83-9982-89d921aa9bce@sirena.org.uk>
References: <20260518095708.2502537-1-chin-ting_kuo@aspeedtech.com>
 <20260518095708.2502537-3-chin-ting_kuo@aspeedtech.com>
 <659a6593-0223-4a26-830b-1390326b84e5@sirena.org.uk>
 <TYZPR06MB520319C6F48144C8B8470740B2002@TYZPR06MB5203.apcprd06.prod.outlook.com>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p4rKxTD+lxMaCbrE"
Content-Disposition: inline
In-Reply-To: <TYZPR06MB520319C6F48144C8B8470740B2002@TYZPR06MB5203.apcprd06.prod.outlook.com>
X-Cookie: Huh?


--p4rKxTD+lxMaCbrE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 19, 2026 at 12:43:44PM +0000, Chin-Ting Kuo wrote:

> > This really needs () to make it clear what's going on; the precedence is well
> > defined but not everyone is going to know that off the top of their head.

> Okay, below change will be added in the next patch version.
> while (k < cols && buf[(i * cols) + k])

Sure, looks OK.

--p4rKxTD+lxMaCbrE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoMYVsACgkQJNaLcl1U
h9ABXAf+K7kfpALiXCtanzo+MPWvQBSK1tW5fmc2s/VpszEGZP67VABdJyyHdltK
oChTSEmox6yS8/PEfQxu67hYI7YrJnFiBbenks1PBcT6TlTm1v8g4axGlj0Z5nLk
MQQH3pnX03llGMnO7lqFW1oEM8P9WX5RDby1qc4lC2pPtumnm3dUBieJ3a1nJz6/
4zbxgf4g1wNJfjVJV/AxMYaamH04So7cA+dP8DRo9SigNChP2qsBrZUFwkKoTJxC
xMmfs37og9ilhbtq20PhSZvsNWpw37ZMg/DANqdFShGKkkKlha4QDmuxPP0wKbfI
wozX/aOtz84I5nXvLz5whlwPviaAMQ==
=2idF
-----END PGP SIGNATURE-----

--p4rKxTD+lxMaCbrE--

