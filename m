Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027EC606A32A
	for <linux-aspeed@archiver.kernel.org>; Thu, 19 Nov 2026 23:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20260707.gappssmtp.com header.i=@ndufresne-ca.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=drvIPldN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVv9D5PP0z2xmh;
	Fri, 20 Nov 2026 10:01:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::92f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795114930;
	cv=none; b=FGI2HaV2dkR7eZAV0WkTdPK7sdUS9Jxcm0pdH0yxD+/GM3rwYiZ6ZYySaYfIcrtAVsXsGDO2wbmvBu1nWda9u/YRd9RTOqcsEduJWKEp91sWHRgeTTSnRhpzAHjyHnkXe6tlX7hACraLY8PubQA3X9EtfTZEMWqhi94JOKvalKn/WTQpWbY5NmHiviTpKV3WnPvd+ykn0+G/SYKKLPSwA0vqk+VeZH3vy5LElNrWlmBz6Lj84I8zlqcRVckNFsqugOvoS3Ij3zTVvOaPYY33hP5dGac7TM0B++EI+hxLr/RuonY1gwkVSJ7CL4letm1xF/rDgciadefag9WmmtBOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795114930; c=relaxed/relaxed;
	bh=hKkPpNGKPc9dB0PHZyw3/Ep3fUq1c/BlK7UqcWPEb1A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KS5PP1Gd6hEkY0sW5i2LTC3vzWzWHtowByO70g0bIOd0kQPt7JrfO32Pp+poq+DjpWI5PvdoykqJgVJNUUDljZZ0Qbh8ijE6UZPMxLkocsyI382aqJUshguwbLc2oMfEEGkRLMvAx0tDQSz9WTt3+7RFBalkagmuT+/maOvltishWkzsim+8RmY3ha/FJPhfDnZ4FisDYN7d72/ExLK0A9ATT2/1cD+PmMRSbh0tXfn8nn9QkO14N0DKMq0ozuoIGEs5CZ7IVxEYMd0+pGsoofNLqIYyzi6CMEeRop5/i/GoiDkqp40KtDZy0TvUMts7A7PSNk1iUbU6qiahZV/yQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; dkim=pass (2048-bit key; unprotected) header.d=ndufresne-ca.20260707.gappssmtp.com header.i=@ndufresne-ca.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=drvIPldN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::92f; helo=mail-ua1-x92f.google.com; envelope-from=nicolas@ndufresne.ca; receiver=lists.ozlabs.org) smtp.mailfrom=ndufresne.ca
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ndufresne-ca.20260707.gappssmtp.com header.i=@ndufresne-ca.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=drvIPldN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ndufresne.ca (client-ip=2607:f8b0:4864:20::92f; helo=mail-ua1-x92f.google.com; envelope-from=nicolas@ndufresne.ca; receiver=lists.ozlabs.org)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVnrw5lcpz2xL1
	for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Nov 2026 06:02:08 +1100 (AEDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-990703f817fso61421241.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 19 Nov 2026 11:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20260707.gappssmtp.com; s=20260707; t=1795114926; x=1795719726; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hKkPpNGKPc9dB0PHZyw3/Ep3fUq1c/BlK7UqcWPEb1A=;
        b=drvIPldNm79FmljTZzyVOvkREU9u0btA6vmAY9JGeXCLXUpK6JhPqYmQsDu2XXcHDg
         qNLjSKI2pclGEy3qXEja0C9cCDues7MLgw5fli2x/Tv9cMgrzZT0yR4Zqt5hl9quVosi
         4lRPjNXngOkWZMHMyjdLKY1VfQAXKI2CU8wZGxle3Bmr2HLprU8W60NLGY7LElMOoDJ5
         SyRM9gXnDxy0mhBcDq/lWXAR4pGWbblcnnzRRFtRHY4LX60aF4UGdBqBiFEvfb56L6zP
         DEF7AIbXO3fwx2B/1Ubdfgr6TlKuZDPTs4IPK0tzB4s22N3UrWLR1zoo6Y53t5mGXaAa
         xF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114926; x=1795719726;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hKkPpNGKPc9dB0PHZyw3/Ep3fUq1c/BlK7UqcWPEb1A=;
        b=Uym9e959U4LXP7yLcyF9VDYogII5J7UVyFUlfm2Dvn0pl7lKMKTgEG0AUEQgtYDlUm
         oNBKNQj8mjPVSxuGTWwET62eb/ZRTTEevi2B7cZPXPtbkKZjpRnIjSCBS+0Ja1hwKUlc
         67b2p+8NM4ymVVAERk5VPTvNVMoQL6PCRbEsaq8RpxUIV+5FZMq3dWU8QRkqSRvYJjsy
         9RTBwVpEWehxrNgaMcBrZoy/wz8gIePUzMuVNVpmGFwqrZ7M5pZgZ89Iqxf/co8yOwQb
         HGb+Pn5JVeXvIUFMqajEENFJXX5WSRrBCDVwxN5Z9vk1UildfwY5KlhvP0ZmXKN42wHY
         lr3Q==
X-Forwarded-Encrypted: i=1; AL+hErF0yFgCwtu57Czcl+hAxYUcDM1D8nQy6UeuiibGgGW8OE32Cy2U946V8mil2jzWNecuuZ1tIh5PqgMjgxE=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8cmwNGPEkjgZiEnewyeLJSvEX0iqY3Ml6sA2w+Cnfe2GwM9Xdp
	EKorBt302cSlKfn12SnTQrbl/5SQcW+IFP67ViJYdsVujX2kU/MPv/4ZXw24A4gSsD0=
X-Gm-Gg: AZFdTZebmrGdvav1JyeEPEv3muwFBtQx+/hr2gow8BVTRgnYU474boG1lKMc9NdMzol
	CpRXAfXgbYCNkOjgb6zfZvUfZG0wNKmv+F63Er+DwVT+Jz9hjGeY6LVmexU2rFacam06gKVFE0r
	G6+qaeUXGnAEOriyObTK/UaiGcOhh9d2jGE1hE5k6gAd9xdV0bwCz+Z8X808C4qXjf5vLoY7Cp+
	RNd2FJ8kRHpOLry7QhGMRRKK/n//TmXsJ43OkJvgHtRLXZa8BKmFRAZu+nOqM6Hq3L+6wPGy196
	sjgiw18Xn0LM9pBxVnST7MVBVY2SojVxLPmRzrfdX+A4csWgmT44OBxGg1JozylcoixRkcjZvfk
	Pwt0MVMA36tM4fpRugJVmp25Dz0FL5xsL3kS8Ca1VCmBNy47uTGhllRvkg+bae1G743U0GSWPom
	cM16qL+Us9yhVTdEe6LBgk1Eq8k8iBwQ2TCVDnD7c+qxfd9jOL1c4Z+ySkiVX6t3zZXDLlOX8eF
	3yuR9uNOvwQFUntSa9CPK75Z9/5JBR/ZBHWl3uHO3+bPE59IXUlxs+4hrnsbrJGTHc6lMC3IFkC
	VCHn0mch1QxLg03V5ms80K20dg4jKbgeplxZg+moIsQeqXpZEXKfVHI=
X-Received: by 2002:a05:6122:c88:b0:5ca:f811:25ac with SMTP id 71dfb90a1353d-5ee8aefbb61mr486259e0c.14.1795114925522;
        Thu, 19 Nov 2026 11:02:05 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:8ec9::c41? ([2606:6d00:11:8ec9::c41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6df8a28dsm809462241.4.2026.11.19.11.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 11:02:04 -0800 (PST)
Message-ID: <84fd9703862c225d63d973cf170b06ab7a962312.camel@ndufresne.ca>
Subject: Re: [PATCH v2 6/6] staging: media: cedrus: Use
 devm_of_reserved_mem_device_init()
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Daniel Scally	
 <dan.scally@ideasonboard.com>, Jacopo Mondi
 <jacopo.mondi@ideasonboard.com>,  Mauro Carvalho Chehab	
 <mchehab@kernel.org>, Eddie James <eajames@linux.ibm.com>, Joel Stanley	
 <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Minghsiu
 Tsai	 <minghsiu.tsai@mediatek.com>, Houlong Wei <houlong.wei@mediatek.com>,
  Andrew-CT Chen <andrew-ct.chen@mediatek.com>, Tiffany Lin
 <tiffany.lin@mediatek.com>, Yunfei Dong	 <yunfei.dong@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Joseph Liu <kwliu@nuvoton.com>,
 Marvin Lin <kflin@nuvoton.com>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Maxime Ripard <mripard@kernel.org>, Paul
 Kocialkowski	 <paulk@sys-base.io>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Chen-Yu Tsai <wens@kernel.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland	 <samuel@sholland.org>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
 <billy_tsai@aspeedtech.com>, 	linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	openbmc@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, 	linux-aspeed@lists.ozlabs.org,
 linux-mediatek@lists.infradead.org, 	kernel@collabora.com,
 linux-staging@lists.linux.dev, linux-sunxi@lists.linux.dev
Date: Thu, 19 Nov 2026 14:02:01 -0500
In-Reply-To: <20260902200703.2016410-7-mukesh.ojha@oss.qualcomm.com>
References: <20260902200703.2016410-1-mukesh.ojha@oss.qualcomm.com>
	 <20260902200703.2016410-7-mukesh.ojha@oss.qualcomm.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Zy5+UcnjO9CPStg5/eKL"
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45) 
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--=-Zy5+UcnjO9CPStg5/eKL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 03 septembre 2026 =C3=A0 01:37 +0530, Mukesh Ojha a =C3=A9crit=C2=
=A0:
> Use the devres-managed devm_of_reserved_mem_device_init() instead of
> the manual of_reserved_mem_device_init()/of_reserved_mem_device_release()
> pair, letting the device resource manager handle cleanup automatically.
>=20
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

--=-Zy5+UcnjO9CPStg5/eKL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCav9HqQAKCRDZQZRRKWBy
9KPMAP43HkphsVrqQTwGITR+0glsiS4Fp5Wyse7t/ZPwvyRH2gEA4/6BFP8fPbe6
9p9JGy6Ck2BZu8qjXZw4UU8oUtkiJgI=
=GZdK
-----END PGP SIGNATURE-----

--=-Zy5+UcnjO9CPStg5/eKL--

