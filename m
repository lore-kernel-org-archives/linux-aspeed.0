Return-Path: <linux-aspeed+bounces-4105-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682B4CD4F54
	for <linux-aspeed@archiver.kernel.org>; Tue, 19 May 2026 20:28:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKmTn1D7dz2yQH;
	Wed, 20 May 2026 06:28:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b135" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779157834;
	cv=pass; b=hpqWWk+xjOLw/SyBofkU1WeEJ/glKN3P6R8A7JMw4hB5wTpuNX6yKOqyqFljp2tlGiYWMx0yccIKA6RcAFQJuTpj/46wvv+XEfXzHivuvkA6bPwUziRFaB5aKIn5mo4x0Oc5Hv4WbFgptR5aSeDo1eRzSjcu5fAl5evKaPx8kU9BAR7tR7LOqVSFRZZV47KF520TpBoUQM/h+3dEwvYKmUf6lSO7naHsEW5aEBpb+stmX9jMGijxIS2WFDNj+g/FE/E3/yBGLP6PAA3XbZjiRHZo1Esr9l0KOA40pr8xuvqgiJi6Qoz1QMo4FcsN3wm8uYsMm7F3BEo8L6dU1pF2dA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779157834; c=relaxed/relaxed;
	bh=VdLnXWkJlod6GBXC4HreIgrL/kJTqIvIXNwxAsiN18E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WOLRqyQWh9nS5aa91VQsoKlE5NebYpFKmv1pjbC0hcCBlmf97f5eVorcvMy44X0Cz+1U+gZP8HxDtAJszE2VoMSa3RqfDSMHILCMe4RRSmw5JTsC6hq/13qlud6QejSHE2gLl4fa/KMiTBT/RxP9a5AYisAyid+1DpvkxIEzfFYEKkTWOL6chWSkD3+gtnuvSqD6VP7nTUv6YqyapvWTIsBmOyJmh6hTfv2Hnq+Y8WPdVzydxOGybfDvO/vtmX+Qe6g1y5khsYOSRwYGJ/OykMK64eiSPmHLYLtE0+WCZxMTfinKn/j9sIALLW3QIxumNUWjWsWUjTnTWX9YeHG+Jg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J8pwwCYd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b135; helo=mail-yx1-xb135.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J8pwwCYd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b135; helo=mail-yx1-xb135.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com [IPv6:2607:f8b0:4864:20::b135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKJYj2PqJz2xwH
	for <linux-aspeed@lists.ozlabs.org>; Tue, 19 May 2026 12:30:32 +1000 (AEST)
Received: by mail-yx1-xb135.google.com with SMTP id 956f58d0204a3-65c477a3278so3191100d50.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 19:30:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779157829; cv=none;
        d=google.com; s=arc-20240605;
        b=TqBIr2Njpe8R9jlRmTinTEVTseMh7XdAD9Ex98yJD9uc6nUBe5xBysVcbs/3l7Cig3
         tu20wpZ3GhiAF23cRpflazCQrOasU9P3DjiB7iob2XyioNy3AAB7Pb7xC9AxYMGhbA8m
         8gbhP2ssw2Dxyu28prMXn8c1p5tK2ZQMkvX8NRxODzdbiYPOU0r4/Q5PQlKFlKOz5ygf
         YeLPZ8hIu0hmzkhD2/0pytqijL/mTdpKzVl7+EdlFmj1EzyljmteZqjaBjB7sYvDY/qN
         z87a+BMP0bb8PsfUe7Gb/iCJaR5gUCb3oJ1aFldaTMzU555CAYSlAtgV2BtXbfAHEzVw
         NHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VdLnXWkJlod6GBXC4HreIgrL/kJTqIvIXNwxAsiN18E=;
        fh=wL764Z+frFKPV673VbzvttfW4fNO1TkWrWDgjwBpgUI=;
        b=Vqf8S2ZcqyisxjIXcP5MYp16MuW3Pkxc5f5pHL+kypiWJA641M21ZOQZVr6vdJrNSI
         Sl6XlL5NVcxtSHdYY9IgLzWIDEHDN2Owi9H1M8gwoI55w8g+brcXC7OnTiCnIq6SMMNP
         05sgqxQxTi7iygd1CqZJ0gVB6j5FzKdNu7Zo5kYLXWFgtd0oAqWbiyqnlF+vR2c35N7b
         lE2QSRzCuCCpM5l61k7iFst2xxuZt3sCP0wnAbpomo9POJs/zPmL/H5C2gvbym2EgKtk
         dACmKzG2+dSwG0gkXM1SbPHQqsXWjSY+ex0N+3S3fSjQj7Z/+JRqZ6PmaRlJzIUSXzEE
         jcTw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779157829; x=1779762629; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdLnXWkJlod6GBXC4HreIgrL/kJTqIvIXNwxAsiN18E=;
        b=J8pwwCYdUn6JySg8k0M3ZBXHSs5zQDZ19IWEP2wMT3qyLkY3G0U6e+PP8N+20vjGTD
         rR6s1My2xt+v+eDGqWR++34cJirBqHYXzwm3fM/3w39w4qaM4Hqa5EGlNnYKWhi/w/Bs
         npAi+iMVeUw5oxXEmlJ4FaBZ+242fIY59mRoU8hvGGkL8o3ZrBj1/ZocurD+MXQ0hyvq
         oYWeiO86fqfynqd4RDi+/AIyfIzceFIE2f0vOKaVbH4VhdNDBYjXme7GFz/2L/MHI+LD
         tl44bLgeLaSECzUxzBiVWbMUrEwg0YFZ2ZLJm24rabVB+rWi9qZ4goCk7qWFLT5+EEnc
         lSGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779157829; x=1779762629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VdLnXWkJlod6GBXC4HreIgrL/kJTqIvIXNwxAsiN18E=;
        b=JvkjDiy0O6YBHmxpIObTxrKT8T8tGYyHN6Cb1P5zafaFFvAKDZl4V63Ss4SJEzDaOY
         laH5ekCAbAdh6sPeMs2e/g+Aaob+KBldTlruDi5irBQ82e9FSrE+NkWAuW63UrZLabVm
         nhlRG+YqasTPlsv3cFfvqS8XWpJLHsX721zFSySdO/OGa77yRUkfc0znE2ngS403QHiE
         1xOITFaxWxzX1EFpl8ZGsBBTO0XwA5ZcUB9jJEMI78OMhSBmOFOKqyZ/qOcP2wQeUt45
         YaAEhHX1Wge2AKpNGDFAm9oZ7Da8FyUT7gUd+V6XYSZyD5ZAT38TbR0S0b1KrRfO4S69
         cmaQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6UPnvjTjV+ShLcY7JE9aeVmTS2WR5ULtCGsvtqoOru7FVJQ4hV89E8tGtjESPIJOEvJRxTgbot+6EHd0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YymzOrni/KI3yioXQisOe9YeMx+5Avt9WCGQI+687xP9AqfZJXq
	hegykypWOHnGTQ8u+G1dNMhbcMbwQFWhYyLui2HilXeKGyTOiEopC00N5dPdcnXz2qk3x4GSFML
	d3OOVR5MRsdlZiYO9CcbffKAa2qFA5p4=
X-Gm-Gg: Acq92OFepf5yUtzk4pmpPT42Ot3rP+tDGc5Z3spor4MaEWdAOgKNMSFK51Jd6YwmRpy
	Jk0UjvDnEz5038YWhiFjveo0xIDAQLyDJdlK6yNNOadc/hoj3bqrtWKj1sc0ccUu0tAr0VtR7I9
	jWNiV2rKY8C2DxpCd3ysQ7JBnSAGcODEKOyjcnoYSutaO1hksXZbpXP+BDH0ktfAoJGJux8yb1f
	H6wn0jrjMC/YNGgJG5+f1PtfG/KeQknYrthMG35tGuh8JtGU4J2SSogKQ/zAaSbSbVXUbQX/b4x
	FjfZADeQ
X-Received: by 2002:a53:acc3:0:20b0:64e:a9a1:fdb9 with SMTP id
 956f58d0204a3-65e227fa1cemr14329495d50.34.1779157829471; Mon, 18 May 2026
 19:30:29 -0700 (PDT)
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
References: <20260518033440.17569-1-prasanth.padarthi10@gmail.com>
 <20260518033440.17569-3-prasanth.padarthi10@gmail.com> <ddb781dd-e117-4f9a-a5a3-94c192d8c2ef@lunn.ch>
In-Reply-To: <ddb781dd-e117-4f9a-a5a3-94c192d8c2ef@lunn.ch>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Tue, 19 May 2026 08:00:18 +0530
X-Gm-Features: AVHnY4JaeDtUFpVTlb85c0qbNvo1Pm4Tax_KEyAn6qJ236xPn2YUFjmk-qtw3Ac
Message-ID: <CAMFFDGjg-ZscFf8g_6=rkCeZ6L7M+hEsBnD76Lb+sGaStWQ7ug@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
To: Andrew Lunn <andrew@lunn.ch>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch, 
	devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Understood. I will not rely only on the vendor DTB value for this.

For the next revision, I will drop rgmii-rxid and use the conservative
rgmii setting unless I can provide board-level evidence that the
required RGMII delay is added by the PCB/PHY configuration.

I am arranging hardware validation for this board, and I will update
the Ethernet node only with evidence from the board/manual/logs.

Thanks,
Prasanth



On Mon, May 18, 2026 at 5:42=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +&mac0 {
> > +     status =3D "okay";
> > +     phy-mode =3D "rgmii-rxid";
>
> It does not matter if this is what the vendor does, it is still wrong,
> unless you can show the PCB is adding the delay.
>
>    Andrew

