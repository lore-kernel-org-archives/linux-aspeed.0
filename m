Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D19606A689
	for <linux-aspeed@archiver.kernel.org>; Sat, 21 Nov 2026 02:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LGT5kC1b
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWbFk2zxWz2xXB;
	Sat, 21 Nov 2026 13:07:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b12f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795226874;
	cv=pass; b=ob14R9zTpifLAE6i4PrI6WAM2ybNfvH/saVaSNTrDAJaa4CcoMbj5QeQKGx0pFy1jGqq+ayRBiHjIvbZB0WP5iFEwwTq/LdJ/gBNOvMCt7vID7M0IK7WIRhvtbaWeXm9CS+/awXSUipUxb28FhLZtGy3qok3p59K/4t51y156nDpkrIC2o9iHEbPl+94OrkYnzqDLT9+WPSa+uZZqKhxGQKK+dsJpbCmjaknO5MvkF5sRv+yBuCUQKiZui7tJvmvdLN4GqUtsRPuYdo3xUYlNWuUykBkCdXby5V84U9xL4tEVPxe4SqZh2eK4W1u8o9E5ndXQTnXBfqCTKCZSA9dPA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795226874; c=relaxed/relaxed;
	bh=HGjW/MMwdvPFqEPVsERwdloYMbx3HCaULFAZmemW7gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVrHOnw7FjuriZ4pXqzy333FAowojXNwSh1oOvICfb6skfKh42Xig7rJ5g6we8XAdP7v5yCrdQdFbZ+xedyeIwSCPQaYUtYjWJk6WsJkpd5yyDcujSIZcpqHCYx49ieyyH91gWsNRpa2/pldCth8CTji3MRKH5cLMrvdlGGvlNyNM20ylOnzI0x2CSSDo4CnbRgt6RzXIKpRoextS4jFdsDKxMJrGQyBYqnNhVCr8Uo0QVCPEQH/BiWEuq1t+3WebxUZyp+kSnzoQbkiVFIt0tKaUDZJ+6s7/qLxeT+IkNuH5rEuhK5nPswMFI6G+Vm+gAPb6SSM5PQQm+9THVJ0Hw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LGT5kC1b; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LGT5kC1b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com [IPv6:2607:f8b0:4864:20::b12f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWbFh4SKlz2xLt
	for <linux-aspeed@lists.ozlabs.org>; Sat, 21 Nov 2026 13:07:51 +1100 (AEDT)
Received: by mail-yx1-xb12f.google.com with SMTP id 956f58d0204a3-67db8985419so2113374d50.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Nov 2026 18:07:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795226868; cv=none;
        d=google.com; s=arc-20260327;
        b=eG+HnonnG1lovAo3qpWXpVXxYQBIkje3A64vP5shM5aixeykpnhwhfL864nNYrAx11
         C0DXmuxJVRHlpSiR+kBRw+d2zS4nWhzrkM5/pAnFKfHcLGx9rhaMTRux0htjbJwSh3vr
         vp76HDMLVqwlNrE5VjJz0BrhzJC1YNnNvtdAr5cvAsgfDSC+t7sauegoqYTXsItMsiVG
         zjGx2i7bKruxjZITAvz+KDVPHysV7Crpz9LCqh8lX/hwWr1hTjHRBDaxOsjoWZTQEPNH
         Oz1dTvy58lmzCgml87sOoxMGZoVEuht+X5iKpnRnmplHP/OfDNkdMijNoBrSuotr7jSz
         Dvsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HGjW/MMwdvPFqEPVsERwdloYMbx3HCaULFAZmemW7gQ=;
        fh=GGtbg8GTouZU/u3eQtZr1RyvRT8TyhbghDGnzLWv39o=;
        b=Bvg3mU20LF67aL4LpDUow4n3NsExkJkvzQeniVZXoxRXVr07oKqJ7Dgo427BWsZZ5C
         gaSQXlCCvKfW/U3Ab6VnaKFBM+sfI9vEXHCjgg17YaLt2bi2YzwI38ln3hFG4H+pnTwD
         NB8iLMXQcYr2IZWNwBKU/58Az2AEEg99D93pSdBFIy7kYWA9ao1WORpDtC+rKENdJayM
         ZkoiS4ZaBAHoPULE5AyqxHqly6MAFG4X1KsQXuGMjJH18dgAQPbaIqcXCWifbPCRyC4a
         d75Phbezj/J4XYDU150euAFRIFALURqsn8habHeMNj2j7i9X54/z20mn9C0kbxGKMNdZ
         3g5w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795226868; x=1795831668; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HGjW/MMwdvPFqEPVsERwdloYMbx3HCaULFAZmemW7gQ=;
        b=LGT5kC1bik2Dh+As3WygjefXdXLT1v/NAOCUtcsfSvHtyjcpnuooHapM1NQatgWZR4
         kDwiF1AI8YHf+MT+jZtLFvCFqAlQdOWekhkFjdQLxMloL4QfAvDidjVOHpIfWnrNUC9S
         Zjh9XaUMVKvDGSgvazuEBgYFU4c9p5/LI/Fk9fJWGvBFShrWZMUedAq6pehOBesQngn3
         bAI9YnHjDMEDfiXXP/JKqfrjbqD5n5IsTtKq4Vn6qF5UdU0H0ioh5qKnZMLTLkRMRdvU
         UCj4Ld9Fmkqbs9+vYAHNhwoo7AwxEySBnqShVABWt0UXKYruiRO08zrpICGGHZ08xFUv
         6MIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795226868; x=1795831668;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HGjW/MMwdvPFqEPVsERwdloYMbx3HCaULFAZmemW7gQ=;
        b=cS03e7mMBRoPlFdqQI+ddv0rrEf7P9Kq9w0fI/0sI36pCsQ/DdLi3/wCZqCto4c0hL
         hd7FMKI1wzZZDx4fWW1hFmuY4xNW64ttJfq2unC13XMz45TJJ14VAtz/Ssv78aozG+tT
         tz2hwd2Hb8HqYCsYAJiXyoWgMqYkmrypAAybf3dZN6CNR2GgojomnYR0uXGY/ZGe5Tr1
         k3BTvPA12ObRfAqMTvm/yfs9z22ehmxD3ywGzu8DA4cA3B/9OOg2BRxMbkzB9vPYc4kU
         muQtwIl2VLcUC3u3Fa3/26XBYq7fqq6YNqwGYMEugw6+cfXFGdloBkJB/E3v6AdjelVu
         WwSQ==
X-Forwarded-Encrypted: i=1; AL+hErECkAClYniflZWmbs+QwYWJyLoPwXNiaCmUMMPLiQlmuv9+Jp8tA/x4MzABe8QNPdAsegnyzmSpJOQdD/s=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+2UTqHcgw/ltGZkevKfYlVX3K1LPp1VFyscr6be8N6TyZnM7yQ
	+mQDotd2M4uPZ72cTBXfhfuij5+Mwk6ZBfx/KRLXhevINzkGwCXSdVlHdcNiCmwc0rxwERtUg+I
	1BJBy/YqhTFUphUDWFFgZkvuNN+dL/tQ=
X-Gm-Gg: AZFdTZfHGltT/vLJ3mMbd2Ph7/nyybG2f/EN4Nk71kTiqx4F5hoOVR31xsWZJiGxxYu
	kupSPQkPlyzGcdT7OSEU4xfpbRTDm+KL/UcdyJT/3FRkZGPd1DkyJSs1PlC4hOyZISQwOC2/ySt
	GcRCTGvLILS815huuhzErB8xbLXvgb1o8dFmC4ISDtayoa926jcT1Q/7Zu8x3e0ZzHYfgBl6TbJ
	yKrPu6HyGE64N1OpLw+dl65L1avNCUqVmJ4ese40NqSmV3hqCyP2N6wcNF5VukMHKup/XSTrcOA
	nVwqeDNHACQUdjFmrnkGeLFzMHDufPrxF1RbMuAwUduhf2SIEUYomh3/3xBIjVLhY6LeBtjm8MC
	6ekvYp4Xnto/0IOkVOa2gvIJmYt53taA8jZvyTRTzXvGzNOSqKwSZ+l2cs/I=
X-Received: by 2002:a05:690e:438c:b0:67c:2396:3243 with SMTP id
 956f58d0204a3-67df441041dmr1738856d50.29.1795226868649; Fri, 20 Nov 2026
 18:07:48 -0800 (PST)
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
References: <20261113034213.158390-1-prasanth.padarthi10@gmail.com>
 <20261120174440.123487-1-prasanth.padarthi10@gmail.com> <20261120174440.123487-3-prasanth.padarthi10@gmail.com>
 <f70eee05-1d17-4060-b1ee-f4845b74e3e6@9elements.com>
In-Reply-To: <f70eee05-1d17-4060-b1ee-f4845b74e3e6@9elements.com>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Sat, 21 Nov 2026 07:37:36 +0530
X-Gm-Features: AclHuK-XA1SyrZq1BHyksXey6RIqRcHtTohcQIWXmSS43XQq55hSKSbeB5ss5Rs
Message-ID: <CAMFFDGh9y6JCTJ+Fv+exsDUW=qvkW8Tsi7VfEFTowpT10bJRYg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] nvmem: aspeed: Add read-only AST2600 OTP support
To: Tan Siewert <tan.siewert@9elements.com>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, ryan_chen@aspeedtech.com, 
	billy_tsai@aspeedtech.com, neal_liu@aspeedtech.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tan,

Thanks for reviewing v2.

I misunderstood the distinction between inline replies and threading a
new revision. I=E2=80=99ll send v3 as a new thread and link the previous
revision in the cover letter.

I=E2=80=99ll rewrite the commit message to explain the hardware behaviour a=
nd
design rationale, and move the test results below ---. I=E2=80=99ll also
include a GitHub link to the design notes as supplementary context.

I=E2=80=99ll address the cleanup structure, naming, register definitions,
shared unlock/relock helpers, error handling, redundant
initialization, readback and copying comments.

Thanks,
Prasanth

