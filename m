Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EDF606A31C
	for <linux-aspeed@archiver.kernel.org>; Sat, 31 Oct 2026 01:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hIv7cFDX
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGg9r4P7Sz2yFQ;
	Sat, 31 Oct 2026 12:19:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1132" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793345326;
	cv=pass; b=GYShGC1Zx1X5jTs+cS3R/xRvrxms13OnAp5UHIT7mrUKbjMVaXT80v5WiF6IlfEYnqQJyhaxnDsCy8JUBVFewde0nOTq3t/XfgiJvC+0CeWzEmQMyVbn0ungIj9TvBg/EeHsydHnLStkrLWaCwIH/zMK208LAe6PCcM9EwKTiiJTt6MkG+dZApgfjoU1mSp1o/S4IoN2BjfvXHtnOYrtvlkQwiWbJ31Vz0L7RVFP8uOMXCgEFxuQddbuQp3CKib0w0GjjmeMpWk1mSp9lq0mv6gFaMf6mqUdhwxuYQY+uL+bRwCviqjbnY0x/JVR/D4i5LWlFvVeLm0iL230YwiRPg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793345326; c=relaxed/relaxed;
	bh=7PxPIeRuNsvElsGXImQTEuL1CpgybTHblbxvuB0DOLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQvK+I+5+8R1GOK6ADnO74znYSsvZtsh1QsZPtw8/M5E13MNLKC+teSImdir/l/1911A+ThvPOsnIUbBEGO7YtcLsNl/sC3ekTRs5/uIb0etxZYdIcOZkkGVIVLz+wRLRpF8qeKjySeHTBpEpBCaRQOCsLFyLlOL70n0uEvZrG9VCOZi1/r1Dy08zAyC8MtKwW3jclplPdU5O3QMKPmCP4Pao+1xHa/2oKW2AaUn4tPYTBFJv99ZxR33nqjxeLbi91cczJIryqvujX/YiSv4xYbpI7nalPsho/ou6/I1HYAx5EB+zIZ2gJj4iC6rOZHy6cfTHThXxeRAQA8F9vUVdg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hIv7cFDX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1132; helo=mail-yw1-x1132.google.com; envelope-from=wenst@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hIv7cFDX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::1132; helo=mail-yw1-x1132.google.com; envelope-from=wenst@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGCQ45V7xz2xqh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Oct 2026 18:28:43 +1100 (AEDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-8565d77c277so3291647b3.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Oct 2026 00:28:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793345320; cv=none;
        d=google.com; s=arc-20260327;
        b=eMpi+s7ixGtcV+XJfT7YcJlQmvALpr5S0oD7Gr8BphqqpBuOjrb3iVHgXWzvfEabzM
         d4KwwOSHy0EyuMignHW/GSZAhMJQo2X3Vn1LhXzWV+n11SuLudIBaqUA8hPTtTr385YN
         Te8SMXGOZ3nvRylbK7FK49jyyjCFo/jcjsRWamtmqGnLj+g/j7s4lMsRAL1U2AMVBPpL
         9WWhjRmILi5LJ6dyUJ3PITfsc07DcLwav0Y5fuzkcR4CnLG/wEdXC6dFf7/kdWmv41Fz
         bU7yz1+dDcmSunIlNUMd+2G3GksXWBzhVJEUoFRL/cVuewASFgHde8/rTov6wwjsFS7R
         Dfbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7PxPIeRuNsvElsGXImQTEuL1CpgybTHblbxvuB0DOLI=;
        fh=g6zLDvCFyB4CHcHgDGKsLMUV73/s03nTkbVxBAbaCKg=;
        b=cC6e1QLiqsjnrMsC2sp7IWgcSsCOyjidQSDeEnxq6MbzrPCd5Bs/b/P35+inAqUnvA
         Dwm6BZM3zP7oBTdPJOsfKBF7b5EaOWJQdI7u9J0VPqf2uYA2axoU9g6uVETbMEU6dEkY
         Ze4G/6g8AZpFkdKqjJ9iGrqUMETSWgbhf8SwJNs41ZnsmxZQmiFu7ZXU33Itk0R0G/XI
         MSjgertqIhae2s4ygJIRYG6G4VtVI89L3h+621EH5ESJQ4Q7Gae7VzU9/lWiiCHtRRUD
         vaYOsGIDup4RuhiSZf+KjvkgbuYjLJmlcvv3npPXj6HxKaSTYromZn3CQSSCjIaF9cWy
         XrSQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793345320; x=1793950120; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7PxPIeRuNsvElsGXImQTEuL1CpgybTHblbxvuB0DOLI=;
        b=hIv7cFDX0Dw3VpVdJ5/NZ1lXknYKerG6qR3KR5ubTBaUPjIiWp5Pufb/9f+c1nhQ9g
         6lGsqPqudy87QsQ8UMWkb8XS3f2oyco9dwzzX1XERJdnui2ghXGKipa1nLOVW4uw2goD
         rb9Xxwlw1fOZ8huU6WEuOtRCj9iVa6Z+l4bYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793345320; x=1793950120;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7PxPIeRuNsvElsGXImQTEuL1CpgybTHblbxvuB0DOLI=;
        b=CuVzGH20RPmQma7QckjAGtbzYn1sSR3POy81PW/IsCSKRMC1A0G+y3A9xmRIQyMGQJ
         KyS9pPQCBP/FVtcuMmONzy5DI1ZmDuJ8k13U7II0nD17TJLcRFgERFkPimHqLFO9XOie
         dtBePl0uz8TURRz0xmyj8o4qzhB5X53r4CEOC/SOVfCt3/hWI2eO3YmX1ECGHAYn+ANa
         focJcrEAdInFDwwamjUakqX7kpWFOqx/sI8eNxqTom0CIhJgopXQm9YQKksoH1dcXsHC
         qAzAgxEWw9kkqUQAEXcxG9Nge0Io+TP/p4soKgPhe4hyIB2ZqdSmMEWLWQchOF8Ais1o
         ymYg==
X-Forwarded-Encrypted: i=1; AKwUvBzy2yNO1H1zzHfmNbuM+0H/fw2sMfwSSrCGlR2eUuBWJMGTv2mQOo9fE7YYjFZ/k1RqH8Vqd+CywKGxrnk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKgPHTa9KRK+jXaCzMy0jhpxNDUWmKzwUapiFS07kVWFXK2sFde
	/0aSbDarOMN8XU5Qnu8jPjPQKkIDUrLagM+I+1jWLfTB2cD4TZ3jKSCc2TCv4i5lRc3CjCY5wOw
	jHE9v3f1SCxdDkEufG1jv2rXRVTV+hh9cCGfMsdA+
X-Gm-Gg: AYBFou0w+H69DU7wm/gNFwvfKH2xBx5vURTHdl+ywq1kVWKCtylbS2yGLplHlz1P50S
	jRXzkAJHtYnT/FJ/Gut8MbxIARZ5bTh/lCnfDgyZM2HbQgN8P9CK2eqlLsabaVfMJIVyp2o7dmJ
	dKvM5y7Fhmdto0RK33mx3eoUBKUEHGCX1MZhAcTtFsRyNAQQ74xyWqfMUuA/ge+ugCKLmUmr9Yp
	sH4IV/VSmkmTYWfvpfG0g/BYzMLELAiNCnKUol3oxyvZS8JlJbxAXYf9oOcxVzoZXQwHjq9wbRz
	8PNWXxt72cZYy4tR49xR/Y5r/Gm/sm44gmZYLiA8PgqJQhBSTVxoPCtFbcv08JxSbtCnvSauXdA
	j+VtvxDCG85w39etJkcOvbjjAv9WCQ3CdZL3wri2gMucT07f+K1lJ1MWGDvXgcYmChpI=
X-Received: by 2002:a53:ac8a:0:b0:679:9afd:c0c7 with SMTP id
 956f58d0204a3-67ba508d24fmr864212d50.126.1793345320085; Fri, 30 Oct 2026
 00:28:40 -0700 (PDT)
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
References: <20261014082037.1774672-1-wenst@chromium.org> <20261014082037.1774672-3-wenst@chromium.org>
 <7020a7a6-332e-4fd0-a659-d82eb768614c@linaro.org> <CAGXv+5G1kgyumbj7wGf6rPFbg3spSO0zYmEkn-hZT4qUdJbytA@mail.gmail.com>
 <03375a31-0ac6-47a4-b0dc-6327080e1622@linaro.org> <b4c0761b-34f2-42ad-97e7-ab34ae776281@oss.qualcomm.com>
 <8d4d3ec2-3c97-4a46-97f8-048fdf81b853@linaro.org> <CAGXv+5G_ig=k-eH8Cp0ES70WxTHcBS2TVj9VmHaG9caROiAuQQ@mail.gmail.com>
 <8ceba969-91d2-4b43-81d0-b26e7139664b@oss.qualcomm.com>
In-Reply-To: <8ceba969-91d2-4b43-81d0-b26e7139664b@oss.qualcomm.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 30 Oct 2026 15:28:28 +0800
X-Gm-Features: AclHuK87PpF6mvOIXqHCbuY1WKimiNRH2tQGnceMsfo-UR5TI782gxdvYJm286Q
Message-ID: <CAGXv+5GFogx_kS=N1t8-SFTp+HyxLtoHzhnL6t8Zn0GBiqMoKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: usb: snps,dwc3: Fix downstream port numbering
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Sven Peter <sven@kernel.org>, 
	Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, Michal Simek <michal.simek@amd.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Peter Griffin <peter.griffin@linaro.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Yixun Lan <dlan@kernel.org>, 
	Troy Mitchell <troy.mitchell@linux.spacemit.com>, Minda Chen <minda.chen@starfivetech.com>, 
	Shyam Pandey <radhey.shyam.pandey@amd.com>, Wei Yang <yangwei1@eswincomputing.com>, 
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>, Hang Cao <caohang@eswincomputing.com>, 
	Li Jun <jun.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, Roy Luo <royluo@google.com>, 
	Yang Xiwen <forbidden405@foxmail.com>, 
	Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>, 
	Robert Marko <robert.marko@sartura.hr>, Xu Yang <xu.yang_2@nxp.com>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Stanley Chang <stanley_chang@realtek.com>, 
	Ze Huang <huang.ze@linux.dev>, Aswath Govindraju <a-govindraju@ti.com>, 
	Roger Quadros <rogerq@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, linux-aspeed@lists.ozlabs.org, imx@lists.linux.dev, 
	linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, Mathias Nyman <mathias.nyman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 5:44=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 10/15/26 11:00 AM, Chen-Yu Tsai wrote:
> > (Cc-ed Mathias, the xHCI driver maintainer in case I misunderstood xHCI=
.)
> >
> > On Thu, Oct 15, 2026 at 4:44=E2=80=AFPM Neil Armstrong
> > <neil.armstrong@linaro.org> wrote:
> >>
> >> On 10/14/26 18:36, Konrad Dybcio wrote:
> >>> On 10/14/26 11:44 AM, Neil Armstrong wrote:
> >>>> On 10/14/26 11:29, Chen-Yu Tsai wrote:
> >>>>> On Wed, Oct 14, 2026 at 5:28=E2=80=AFPM Neil Armstrong
> >>>>> <neil.armstrong@linaro.org> wrote:
>
> [...]
>
>
> >> How about the USB4, does it use the USB3.0 port ?
> >
> > I'm not familiar with USB4. A quick search says that it can tunnel
> > USB 3.x, DP, and PCIe, and it doesn't have its own USB HCI defined.
> >
> > So I'm thinking the USB4 controller would be more like a nexus node
> > or multiplexing node, or perhaps like a USB C connector. It has input
> > ports for all the protocols it can tunnel, connected to their respectiv=
e
> > controllers (XHCI, DP, PCIe). The binding probably would be very messy
> > if one controller supported multiple outgoing ports, as each downstream
> > port has a 3-to-1 relationship with its respective upstream protocol
> > interfaces.
>
> Yeah that is more or less it.
>
> There needs to be a connection between the USB4 router and the native
> (USB3 *port*, not hub | PCIe *port*, not RC | DPTX) protocol adapter
> where the tunneled packets end up at to create a PM devlink between it
> and the USB4 router.
>
> ACPI does that by adding a `usb4-host-interface =3D &reference_to_router`
> property, for DT that's still undecided:
>
> https://github.com/devicetree-org/dt-schema/pull/196
>
> As far as the Qualcomm implementation goes, I was hoping we could
> go forward with base1 numbering as the DWC3 is an XHCI controller:
>
> https://lore.kernel.org/linux-usb/20260929-topic-dwc3_tunneling_state-v4-=
0-63e296346d57@oss.qualcomm.com/

I don't have DWC3 manuals, but assuming its internal numbering follows
that of XHCI, you can't just use "udev->portnum - 1" in patch 4. That
is the logical port number on the root hub.

Instead you need

    raw_port =3D usb_hcd_find_raw_port_number(bus_to_hcd(hub->bus), port1);

to get the 1-based port number for XHCI.


ChenYu

