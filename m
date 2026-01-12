Return-Path: <linux-aspeed+bounces-3296-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53F4CF45D4
	for <linux-aspeed@archiver.kernel.org>; Mon, 12 Jan 2026 22:41:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqnRH1k1mz2yCL;
	Tue, 13 Jan 2026 09:41:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768252683;
	cv=none; b=I7cYV4G6MHGJKfqWIyIR3VL5ekfsgFelONbtpkueMg0rOTtrGGAlj1Kk+NliOuMYQaNCPYxdRbnIgyAh0rqlkGtRCP34dnZBD0XjyIcdTfDzdONTMVMNGONC5fwIrnAK4ORbJ/Fx5RPHs8fK72kIFHvMjQIeLdlU9R+QdAehwOkaV0azy5VS9r+PsifveilTYpLhqFz9cCY7XYQWFrVuwflHFq0L+T6i5+d0pDtK5uCpIwF5NEqrPP4qIr68q9oiKhcnEllDhUlKVLwUA7JXLRedvz5mtkB7cpuFO9dAHKTnbn8utnbfMyzxZfNLTRq6GMQg1hKga25zNoz88YVl2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768252683; c=relaxed/relaxed;
	bh=ldGPuGZG523RSoakys4MiKPAfsrjJwPEUi50RijOKj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4pCHwHiJVmbPgCigrOpjMC1ezh1CgiQpHgNcxZ3qUp3dqhOWJKJuABeei+cjDLf1CQlbsQzFUIFj8k9zdlzZ9D6IOSlCoTTbKf65en/HXqCphD7TlbxpmAE3o5hduPOqOWulrVptpugSvqEsvc/wa1t6IxHyyj1QyL+wx/CoE8h4Od5D2HH1jY5kc7CJvxDYd+++AR6e9tMY0aL9NoUtHW5dfxJ0PN/jzkFCMu6Mubn5mJwHn9pVIA2F6m46JHi951EhkJ+xTi9lIVqphe9cpnLXje/YyBhCpIS5f/mXpOdJZLahiiAKoAkXL5jbfLFlcVSlVCIOg4Ev7IwiP+pIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LPzhM3iG; dkim-atps=neutral; spf=pass (client-ip=74.125.82.46; helo=mail-dl1-f46.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LPzhM3iG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=74.125.82.46; helo=mail-dl1-f46.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqlbG32vzz2xKx
	for <linux-aspeed@lists.ozlabs.org>; Tue, 13 Jan 2026 08:18:01 +1100 (AEDT)
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-11f36012fb2so8970761c88.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 12 Jan 2026 13:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768252619; x=1768857419; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldGPuGZG523RSoakys4MiKPAfsrjJwPEUi50RijOKj4=;
        b=LPzhM3iGipYwegx0fT407ySj/K55dMVv02qtRdF+OMcSm/AdmOeO6IzYFDkuxhVjcs
         VG8YQjE6VBODJzUKnjrDkfcQ4WDz+iQRsZu53nQxYYO8I0v4EAP04pESZA62HDautVjf
         AD5O4gBTtoricdpwBGuAvJVEi3Dp9gkUWyZHkLO+a1NBEyO0Ce/g0siwWAL2f5S1IWwu
         u1LDCnbjDAV604cdgxUsW0TYNgCW523LeeEq4a1rL2Yhy/IpMaWIpUwFWh1wOvtur9Zw
         WOYju1JkKCqshCsURiDgQJ3Gdwrg713VflLnCB63Qd/91+OWNBKQZPFqWhN3lHx8nI30
         Pa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768252619; x=1768857419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ldGPuGZG523RSoakys4MiKPAfsrjJwPEUi50RijOKj4=;
        b=ACq31MahW6BJrzf0P6syafe9F2CghBgGpA09gUEilLL2rwSLBBS76TW9e9fnZ7wPqY
         G6NUGvN+rgcaunR856RCuHpMys2AUZg4V3V11lmqmGzLjmvJW1GUgoq+snzlZySTD+1I
         XBtwSBXMek4RpFMHLxm/Lr2YKyrv4XocXK8tNBPIHs0LpeVoazC38uMx+0hXZROEyij4
         3yEqoNwotBJZr+3oG5CJQsEAwwc6GTffDLzNlHKmDsNYi994UUgf3c3lJOlpXMXh0/ct
         G6ba2lpeednwSgfUle8YTz/yCaUp3T/gtUFt7Ar2lu8IMF4bmlrKnvQqlliUQ+Bus0LF
         nu9A==
X-Forwarded-Encrypted: i=1; AJvYcCWv4r0NdyvCzVP4/qu3ZtO1DfXCRJr5g+nM+nd3PJ2cmCXbATe6V2OipY3K2ijDUvGXCHHtIRafgaZC11w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxBdhzVKsCCptKcMuYSJTIwQ7g/FxWieAYkRTsQQXOhw7lURW8i
	07gk2f5t6PC0UzHhI2thAwKHp7UmvzDfiCxz5VU1aTCMRjUGbtnsIH6kotkiovlUSzTZulYgsMy
	RpWN4mXLOjJ2V5x4lcHqwemmhNuT3fqU=
X-Gm-Gg: AY/fxX6giSzOwwGp3itggivkQXU5yQJTuqISOZxogtd1l87W3nWJzIqTC+KRZHNOt9C
	dgg3Xnr8NORFLg8YVNcfdOdQh6oYGMxXhkvB8+I/WB3RahjTgbqBzszQ7898HUDkqRJfoa5vo0e
	Vb85FBE5SH+HKK3Zwc4z0JmjCM4sNtqcjD4OMFeybEvosrmrEc/1JUd/o8YBwzJWR17+lsJupVM
	pHsrr4wzuEL/WiLO3XBiRpcd0p5wEtKM+Z6060X2QkrKhUqXBsLsiekdi/bODFHS/rSD5zld8PG
	8ux6zXwS
X-Google-Smtp-Source: AGHT+IEOZLPJwj/S58CaKJrV3wQ5O6ZbtxN7uz0O09Ew9vCMcJuDYyeoj1bB1o5HdriBJYahGUi2SE9K8dooarY3xtM=
X-Received: by 2002:a05:7022:670f:b0:122:1e3:534c with SMTP id
 a92af1059eb24-12201e35454mr14780318c88.46.1768252619049; Mon, 12 Jan 2026
 13:16:59 -0800 (PST)
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
References: <20260111201040.162880-1-anirudhsriniv@gmail.com>
 <20260111201040.162880-3-anirudhsriniv@gmail.com> <20260112-upbeat-gay-chachalaca-ecb74c@quoll>
In-Reply-To: <20260112-upbeat-gay-chachalaca-ecb74c@quoll>
From: Anirudh Srinivasan <anirudhsriniv@gmail.com>
Date: Mon, 12 Jan 2026 15:16:47 -0600
X-Gm-Features: AZwV_QiIk_am64aGoJ59TKkJjjSWuft6c_UwxN_mAcvJf8KPJOFciUjwqcXNWP8
Message-ID: <CAJ13v3TqhKyT62NZFRz0dP0tov=q8fz99X_HgrJnwkd6Y5nEig@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Add Asus IPMI card
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Mon, Jan 12, 2026 at 5:48=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> > +
> > +     leds {
> > +             compatible =3D "gpio-leds";
> > +
> > +             led-fault {
> > +                     gpios =3D <&gpio1 ASPEED_GPIO(C, 5) GPIO_ACTIVE_H=
IGH>;
> > +                     panic-indicator;
> > +                     default-state =3D "off";
>
> Missing color and function. Or at least label.

I will add this.

>
> > +             };
> > +
> > +             led-heartbeat {
> > +                     gpios =3D <&gpio0 ASPEED_GPIO(A, 7) GPIO_ACTIVE_L=
OW>;
> > +                     linux,default-trigger =3D "timer";
> > +             };
> > +
>
> Drop redundant blank lines.
>
> > +&mac2 {
> > +     status =3D "okay";
> > +
> > +     /* Bootloader sets up the MAC to insert delay */
> > +     phy-mode =3D "rgmii";
> > +     phy-handle =3D <&ethphy2>;
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_rgmii3_default>;
> > +};
> > +
> > +
>
> Like this as well. It's a sign of sloppy coding.

Will remove

>
> > +&fmc {
> > +     status =3D "okay";
> > +
> > +     flash@0 {
> > +             status =3D "okay";
> > +             m25p,fast-read;
> > +             label =3D "bmc";
> > +             spi-max-frequency =3D <50000000>;
> > +#include "openbmc-flash-layout-64.dtsi"
> > +     };
> > +};
>
> Best regards,
> Krzysztof
>

--=20
Regards
Anirudh Srinivasan

