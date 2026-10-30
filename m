Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949B3606A31C
	for <linux-aspeed@archiver.kernel.org>; Fri, 30 Oct 2026 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gWj3hF6Q
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGF2427m9z2xqh;
	Fri, 30 Oct 2026 19:41:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::a2f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793349692;
	cv=pass; b=eOD+x1rq2lBdFtESFVbqSEz8cB1jSlMDubUyGzxzoEMaMmTIYPWH+fvORnpZSE9PwejGctdzkSJQO95MkfaUKHhYAHMmFAIOElzX4SyuEiaeIqZkWN+fB7pkhXc6/X/c4kl69KpB6F1WB5I1mOr8JT8b35dfJg/roFl4YZ2ooJfyrJf+YmIw92VgG1j3JeAZWWa5snrYQSmOWfQYfOC/Q8uOJcei04nogl6gfObjTt8StewXtKomVtQJuYFz3CeYypG6PpCnqKFne35054cOSarkAdn4iDL62anao16i/h8TZTS4kV4vCkY/RfStZibpjnX9YsI9jazXFm4RbYDuyw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793349692; c=relaxed/relaxed;
	bh=UrLH7U2TwTbVq0Prf1EZK1OLwkqGxJZQmo/JtOYxWHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTgBn1YIN1lPTP2a2U9dCe++cK4ztgfd+4xOkQtiPGC2dHaekL9mftASm/BnlAyJ06F2dK+nRvZ3yUSNI/mvEwUUzPDQW85s3tGtbHe4dA6VxowXVF5G/ryKOt3uT4KV10OBpQUcZgueRks2XN3MiBff/SvpzvHwHYsDOSWE/Dj0biTi9VLjD0HioS3yyVd96q7MhgXwDi0j3ZKXBz5d23477vKYnPud53i08X+pJIBWmXEjrEvsvQWOvLJzyp8ERjPnqc0iPdz08ag4GPXRx1j8SjG7Pve9HOCXm5HadFboZUGJJyVBv3XeESj7RLptpwjzYr62+2dDRgbRFjetBQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gWj3hF6Q; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::a2f; helo=mail-vk1-xa2f.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gWj3hF6Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::a2f; helo=mail-vk1-xa2f.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGF223LXxz2xTl
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Oct 2026 19:41:30 +1100 (AEDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-5ead9f60e26so1592926e0c.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Oct 2026 01:41:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793349687; cv=none;
        d=google.com; s=arc-20260327;
        b=EjTQBO1Hx0NPQ2ebKiIkx2xPLvljtw/OclpQn0K59isjxmTYrKDxVx2jVnqS05pHOs
         E+M6z4Geva88x9CLwJ+h2GhtHJP20bWKP6ur1mTPV3Y8RRAIOsL6DhGVRJtNP3W1+nd9
         t7LrS8Rv5jD6SXWx9uQse+kMb71/leZQxdxRe3VnaWWtayOGUI7VDrN28QjB1mZwdmF2
         ihL0KivcCnmKh2/r+zWUoHNOVSrLm7gjBQyoLOp51m9HfaBOMvcm4bl/yXPoIxzhu9e2
         v2Sc7E7vgCvzOfhcK0xmH33yj5IX7+g7uPYc/LP0sfmK6cIiZxDm+l9b7ZvgvS+wUaLw
         TIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UrLH7U2TwTbVq0Prf1EZK1OLwkqGxJZQmo/JtOYxWHw=;
        fh=DoHXCLj5WV5GYe0o7cr9Bi4UBPVd1FCaT1vUy1iU8ek=;
        b=HeAzT8UvlQ9TXB6tlJUa4dN8yYph5Yns5Z/8pByquLD6wgDPKthWKOVIxljeMgUK/p
         AGKjzzcKMD+JoBfgoH1TdE5Yju0j7MnCUje6FmyqhsVTFFFB8H1uCTidGxYw23jHHamj
         m7hc92NDYCl8/Tk0EC5rIXE1Ihhoj5OUvx0uwqCMH1MNPsBjLVcF5gSYx65rMGW04w40
         iHXdhD1aiJjHKXJi3x67iYOmE3k3B6kAg4Iy4FUFP3ei62ECmrDlmKBl3u0A1RfeTW7d
         oIB549HM+da1MeW70n5+m4UXzskGT1l3n1NzKw0d0ZCimNQXJuyAdUwFLPvkaVGAmK4l
         eeDw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793349687; x=1793954487; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UrLH7U2TwTbVq0Prf1EZK1OLwkqGxJZQmo/JtOYxWHw=;
        b=gWj3hF6Qrtv/HsP91WRKv8XDoptDg1ET5GpjPySi/8G5ocEq/SG053Bk043aCRgcno
         qV2ZRTsN6NLCTWSzyx/SxkAc5g0WEnpvTVGElU+RsGEHB5gvsAwOjXzegbpRyDOBI86O
         bGbSM8gj95XlxNoG0eIGNyRn6oT/LnodtNRHdriJIUeUcubFV6I5o+WczKSFZJ1GmwyF
         ZFwyWZOebFxU2DGGpXtB9Yg5LaHEdlHzBACGC6P+bVv8kGgj3fa/wKntQYvsjv0F1QQs
         7Zx2ISylVId1swyqiPN6D6ijk8y9h8aCxCGhBdq43FeRmt+Ram5nBSGQQ3yPVjcX5cIZ
         VuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793349687; x=1793954487;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UrLH7U2TwTbVq0Prf1EZK1OLwkqGxJZQmo/JtOYxWHw=;
        b=v6cQcJOPNkDs44kv1NwdwEgp3adDDqQQGmOHN73yCih+1o/dCgQraCf0ikAD4Td90D
         SxJ+2HOa8WHUiNTP/PEMcQF2mLyWSC2WkJgxBV3m8lYsnaNghQsSpmHyoxm7ZdalJapq
         9mVKPq0F/41ZT9TG2rPttMjaW/iLq0dmRdlUy25ulQg/ZS2Lli6Ht0XM2iAztEK4Zga0
         72BNKkxaFMejdD0qRajqXIR/RDphunUxTay5K9aOiS4E5sjiEWp2+OtdDTOjb4qViVV3
         iB/5f83k9Qk9kK5v83s8r9A+QR5Z8UVF+I0wAyxVoyzmCfo+bMGawLwvcYeu0+sJslWv
         owYw==
X-Forwarded-Encrypted: i=1; AKwUvBw3tsqXcUGstX5rQhNtYDf+xdqlzhK7IysTKL3RtX2IhuM79JfNJ2xW1+54dp0XDwDUNPLpGm2hZYO42+s=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLaRhJM4vFbEIFC3y6fVEAEy+bnYGr0awjmNHTIgZsz+7kJamcY
	IvCGay07YuTTleqlYQYcd8g1EhDIPuLVyIVwDINEH4Nkg/Iss/spiKeCjeYEOlL9IFMmpvNE+x1
	6W/m9IZx+U97KFwU7BAJm5Gz6P0LsuNU=
X-Gm-Gg: AYBFou0DDleeM6gCxtU/xX5d5ZhjDla+MACDN973jNC9oLE8wVrNCdx6fLbkqUeYi7i
	hhYzWansvpxS+LjmSHZkre83S3tVH07d7/qRcBhP3HJjfhUAGjdUtRy41SGWsGIwHJCk82Qm4DU
	6syZ2nMHVqwrH5AGhwjeCt9/sWMFAWXAaG8OFt+G3fe01Be1fXh/mKSoo4Pxw44HdL04dI47/wr
	9ww66wtrBY9qOAMghUBRzB2xbu73RN+tJXmcrxnYOCE4vFmkx7WlhllKjbGFNccD1yvcbjU48Xp
	3KQBKhhuyKlJOBXaQR7jWbsKOdNsmO+ebZA3KtF5F8LvY8Pe7FE12hsZYzgirMgCFZiNE2rO6RZ
	W81t8Stf5F/3l77RcUrxNBI13uIKcvkuC/e1x9h19QoSWg8x3mHT8lCoc3wQ14wd278ZpIG0=
X-Received: by 2002:a05:6102:370d:b0:7cb:cfcf:3d01 with SMTP id
 ada2fe7eead31-7d05432ac0amr1782183137.33.1793349687565; Fri, 30 Oct 2026
 01:41:27 -0700 (PDT)
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
References: <20261029-anacapa-devlop-phase-devicetree-v10-0-26ee3cf9d9d0@gmail.com>
 <20261029-anacapa-devlop-phase-devicetree-v10-5-26ee3cf9d9d0@gmail.com> <c78efbed-e91b-484c-b2a8-4e44383bbc30@kernel.org>
In-Reply-To: <c78efbed-e91b-484c-b2a8-4e44383bbc30@kernel.org>
From: Colin Huang <u8813345@gmail.com>
Date: Fri, 30 Oct 2026 16:41:16 +0800
X-Gm-Features: AclHuK9XCUvHE6twaUxwd5Nq_zSeUGonn6zfgdlBk1GcUoScVQ6GTN_l7KvPN_Y
Message-ID: <CAPBH0A96nFFqv4a0--OD=67w=uNkiX5qWb1aQFF9=kGVsUijRQ@mail.gmail.com>
Subject: Re: [PATCH v10 05/16] ARM: dts: aspeed: anacapa: Add eeprom device
 node for NFC adaptor board
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, colin.huang2@amd.com, 
	Carl Lee <carl.lee@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2026=E5=B9=B410=E6=9C=8829=
=E6=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:43=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 29/10/2026 14:38, Colin Huang wrote:
> > From: Carl Lee <carl.lee@amd.com>
> >
> > Add eeprom device node for NFC adaptor board FRU.
> >
> > Signed-off-by: Carl Lee <carl.lee@amd.com>
>
> DCO mismatch / missing SoB. Please read submitting patches document for
> further explanation.
>

https://github.com/torvalds/linux/blob/master/Documentation/process/submitt=
ing-patches.rst#sign-your-work---the-developers-certificate-of-origin

Thanks. Krzysztof
This means I need to add my Signed-off-by to each patch, right ?

Best regards,
Colin

> Best regards,
> Krzysztof

