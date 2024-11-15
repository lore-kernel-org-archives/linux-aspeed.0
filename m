Return-Path: <linux-aspeed+bounces-129-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0056D6DDEA
	for <linux-aspeed@archiver.kernel.org>; Fri, 15 Nov 2024 09:13:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XqWXd1p4wz30PD;
	Fri, 15 Nov 2024 20:13:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731662017;
	cv=none; b=UDOxqEmkwS3s8lmdp01Nc97lKXVdBKqA+nIMv60j41bO+S65t7UITWDRJkSABSEnxG5ZRkdAbu1tBozftIc6bd39M9Uzvj1s/zaP4bpBIIfkFewq65K1MTpladg0MkRA/ap5yu2hLxtfZhio3KRnU8Yd8HKFBU4j82Tkfvgs8uJmtyrwbrC7F6hRW/NmHg/uS+FlqBwVYnVWJLvcbNNqb1rsbgGK7ykD2v8DZ1u4CGiIQXSIXnG4MCwP9T42VX7qhkbsqqZoRrYM2aLZtSCU8jqdjTGlIIPwqC/q/iATEWhGYVewvyWd8bFzANDAzQCScbDM4IgAihlr7dMQWZKXTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731662017; c=relaxed/relaxed;
	bh=yPZVsgKXclOlJH1qoJgcuarPoZsvQmU+kn7v0TjKgwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azxpoyFycKZ0qX5OLF2XsPeGTaRKRLBnXNWMW31E616aOhPWA0M0M5cfbyQvi8Jho7CnGPJ9/YrbAxowW95LTZ8j2/0O5KF2HmQZS54SqJodrRjrkkLxQiBPNuox6XgJ4+IgicSiNfki4n5R0aAnej9lGGTB0qrHcypb2lS8F7eXk6D64OREmKmoW80FPgyXf8eT8jmnmE+3jxwBZYakSwo9jW5QMJaJVCgpBQc+4c9H6S88FM2Fo3Y734KZuBt9B9ekTsufBhPkIw+ZAux4fMfRoX8ozaH9Nw8I+aseJTMmRQ5tKnraeYk+gypBjl8UMHehfuCeXolQkBiJl7yBVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; dkim=pass (2048-bit key; secure) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Zsb7PJ5B; dkim-atps=neutral; spf=pass (client-ip=194.117.254.33; helo=mail.zeus03.de; envelope-from=wsa+renesas@sang-engineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=sang-engineering.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Zsb7PJ5B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sang-engineering.com (client-ip=194.117.254.33; helo=mail.zeus03.de; envelope-from=wsa+renesas@sang-engineering.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 394 seconds by postgrey-1.37 at boromir; Fri, 15 Nov 2024 20:13:31 AEDT
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XqWXW2pMNz2xH9
	for <linux-aspeed@lists.ozlabs.org>; Fri, 15 Nov 2024 20:13:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=yPZV
	sgKXclOlJH1qoJgcuarPoZsvQmU+kn7v0TjKgwM=; b=Zsb7PJ5BXCpssQ0r+SWz
	lH2RNcqPi4KUfnvHZ6wJb1EWjoitv0ZP5RTR9j+jlhEqbzfX+k4VIwnHdLXXdGk5
	Qse5Q8hoznXgveNraWKDo/szDYToU33oCRGd0OuwtPZvli2eaH/xvO+4wGc4JrRl
	zjz57QkZX4sK5vlA2t+d92Y3YxHoIVRupK7aNk7ROaee0B2tJOJy5nysUiJeE3eH
	/Z5rTmX9b/U2MR6YPN4Ginosjgp81gH4iz5xtcAh38Tvh93auPytpSGyaRzFEvxV
	sjEedwRNwrt9hTKZYe1Hq/IZ+a6+S/BNZVzo/mYnMvOl5fiB2kL65BI1ss8tgj0o
	QQ==
Received: (qmail 3419175 invoked from network); 15 Nov 2024 10:06:47 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Nov 2024 10:06:47 +0100
X-UD-Smtp-Session: l3s3148p1@nSH84u8mLK9ehhtH
Date: Fri, 15 Nov 2024 10:06:47 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Brendan Higgins <brendanhiggins@google.com>
Cc: tommy_huang@aspeedtech.com, benh@kernel.crashing.org, joel@jms.id.au,
	andi.shyti@kernel.org, andrew@codeconstruct.com.au, wsa@kernel.org,
	ryan_chen@aspeedtech.com, linux-i2c@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com,
	brendan.higgins@linux.dev
Subject: Re: [RFC v1] MAINTAINERS: transfer i2c-aspeed maintainership from
 Brendan to Ryan
Message-ID: <ZzcPJ9sweqxLZOGf@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	tommy_huang@aspeedtech.com, benh@kernel.crashing.org,
	joel@jms.id.au, andi.shyti@kernel.org, andrew@codeconstruct.com.au,
	wsa@kernel.org, ryan_chen@aspeedtech.com, linux-i2c@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com,
	brendan.higgins@linux.dev
References: <20241115044303.50877-1-brendanhiggins@google.com>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nK9GppicB146/nY+"
Content-Disposition: inline
In-Reply-To: <20241115044303.50877-1-brendanhiggins@google.com>


--nK9GppicB146/nY+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 04:43:03AM +0000, Brendan Higgins wrote:
> Remove Brendan Higgins <brendanhiggins@google.com> from i2c-aspeed entry
> and replace with Ryan Chen <ryan_chen@aspeedtech.com>.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
> I am leaving Google and am going through and cleaning up my @google.com

Thanks for your work on this driver.

> address in the relevant places. I was just going to remove myself from
> the ASPEED I2C DRIVER since I haven't been paying attention to it, but
> then I saw Ryan is adding a file for the I2C functions on 2600, which
> made my think: Should I replace myself with Ryan as the maintainer?
>=20
> I see that I am the only person actually listed as the maintainer at the
> moment, and I don't want to leave this in an unmaintained state. What
> does everyone think? Are we cool with Ryan as the new maintainer?

I am fine, depends on Ryan as far as I am concerned.


--nK9GppicB146/nY+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmc3DyYACgkQFA3kzBSg
KbakuxAAhyZAhgBDfdxkF5LlZpy0BWTyWqEP8GXLw6CcwvZK8FtelfWQ7fJp2q+N
WVUtpFgaiHmEdRr4OGD+1HVFtQgRVu8ybw/jyAt6P3ht1v0AZazUbKrxhJU9atKb
JbMDn5fMwiZu4YXAnfMXDA4VIrLYG3oTAjdDk4dYR4QwCh9EVRA9SJ4Oi+GkKdWg
jEu/KQiKNNTchEmr4Hm/A1tql1hOVKfKCg1dcOtnmzFJrrmWfL1zx2TurjyntpET
+DnDJGYx/96tWCxEVgmp517xxr1A4ontZeGw1VaozHzRjmOBXoW9NECyEg/J7zCd
hz1HefaJvPHACQH8vDYqtYUcAgdQqa06b/emsybRKhyIKkRkY6EG04ExbKEEM4tN
h+CMRFszsBPSIUQF9tErfHCXnK5z3cVHFrl56RVdBUx6Pb4uqIIVeoHGVjPKoCrs
HGSlFczraaD1v2bqneRbpdXoBBmbQjp/N555olQ8k9r9HYKxIYr7wr6eM+4quRz4
pSvGANzlRd6MDxCIInT3bNJ2Agl0qtQxNcjvJHosSuvHNS9Go2fx2To+Qogthww2
+p9jR8SFgPR6Obt0+jj2EoyrPI1ecFreTUxR7D6114J48e7N3oOgEgUsjysS6DBJ
Qz5L3N28hseO7jDZE16gbtqLJgVOKVjUmqJYo3sOSf3wYcy5sJI=
=yNAx
-----END PGP SIGNATURE-----

--nK9GppicB146/nY+--

