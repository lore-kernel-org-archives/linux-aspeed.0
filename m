Return-Path: <linux-aspeed+bounces-4466-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB60C43458
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Jul 2026 06:36:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzqN06y73z2xqn;
	Tue, 14 Jul 2026 16:36:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::435" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784011008;
	cv=pass; b=T0jRbq2um8zRe58aOEzGlh5ygH8wkQLqTocdYWNTjdK8Z8easkv+mK8ccr7+aK6bcHcJLZnGpVBkNf8MYCiImDWtGViLTUUdkUf0CgJi4VhPwPetbpLU0Klkm72TW3ncvNkHaca88Ap1rSZ9oPmuGDSCFcS8asq58P583RX2Qc1u8jYtJcCKuxPAn7YtRLttdJsy0SfFm+ejUvmJoe8HYkQA8uYpYw1i7o+s8aHYFUWkqk2MUAfgMSwEeBIH1u4l41Up+qK67EXSpX5FOTCQGrCTNEugBgzuuqFVxIKcGQoFa6R9RRFrbOGnQueYFmdT2xoMxXE4xccOTEG5ho5gtg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784011008; c=relaxed/relaxed;
	bh=aCojHCJqKCZD1pOeyWJ1gcjn0kakXpXScxWlytGoI3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AddLJnFQ1AxmTEvbfDxbhbFdx2vKCaSu5oFsuoD5Mrp0bVmR7n1eEOaUuKWNYhH2LPcWWFeUAKEmWrvlmnyp2SGFkS4d4rD+4c4q+VxX7auHY7ODWGt5hQhmaDDoq2KkVuTYmGmvr+EFpOQ/IRL8IYRnQTWaBraP0+8HZfC2gizaBQEBWUwMeCPExeL6YvIOnkHq4uBCPhW5vMKZGOOk/FhI5luFnHQsvaEcg22bmtdqwHkRzNjhiQOb+l7uJ2z0vAXOS6KF1n+9Ap6r22pMNPz5nyvblUoJ27ysB1M4aXkjXLF66KK3NL6D5maAr+oiQ4ffPoFiWMUVkhNCNTqteQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=hVcDcNg1; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=hVcDcNg1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzqMz4MFRz2xPb
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jul 2026 16:36:47 +1000 (AEST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-4758bd3731bso436576f8f.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Jul 2026 23:36:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784011004; cv=none;
        d=google.com; s=arc-20260327;
        b=DifFiP5Aw/fiWZPDXdEyah6AhWxGh2RnUP6ZUwEV5ubJX5cJcUIbK/Wftpx9GpYSVq
         BY8W0sxXdPuVmDvhQEEANYhMBl4/OATfyaV9yC60donet4YtqMDhqAi9t4dXGVuhcEIa
         N9+KUSYgOs0apiONm6+HfzUG1iedwYmWwqB1qzjre2tWb5ouufFjtrGQr6LWvWM9vgkU
         Can7ZlvqP6TxO7a+lnndN5E8rCrFNXSun7brErMOcBQ867HyEqf1dN1Vv69mLOkJkWXk
         tLS/od4gttYiPX5Vk8ZL3vJ/J7E3ZOuqLzX94ccEIvKothyRi/Byq2zqlAneTP7dXjX9
         9cQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aCojHCJqKCZD1pOeyWJ1gcjn0kakXpXScxWlytGoI3E=;
        fh=KTBz4fj7DV5UBFS60Vm9aSuKajLbuoBfk6V24Ko6d5E=;
        b=WLl3RKAWalyDvusn63sNqruir0YkVaSfWMb/sp9qW0aHAkxcvUFjLfscCZjgrlddAY
         CWhRizbaGhLHOxML5GX1mOPqlNK0wkTP0THkUMshHWW6OWX+pYHa+oToLmlu4NZQaYdC
         MQo4cOVxPdl7U+BfdTcSZ448UgoXLD8plVNMfUIk70CV6hNjQOTd+NxlO4iIfU0WPfTb
         MPBF/uDCQ68AL7RvodEITuFOLwhtACAXXnaS0zxtEooN4G/mZiMEOvUWk6xZ/ExjkurU
         6HgGaiThAC/9Ms6XYZhZSOc2Z+hTN5RdX+YFIqU2UVRGTygTZd372vP+Y0E32bWxwriq
         jnRw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1784011004; x=1784615804; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aCojHCJqKCZD1pOeyWJ1gcjn0kakXpXScxWlytGoI3E=;
        b=hVcDcNg1nchp7ewfemvZeidA8EBxMOYBwpt0jwBXB25hi6q1XIrbu1j5Qo6YUlSIm0
         cafYK1ILYaN11D2d6l5ef54bCKLK71+I2Kvoeu2pSOXldSl+ydiT6lEQgoplNVcp1IdF
         bJg/FIPqeh7FOe1fSn/8veJqAzilDSMxZKXRjonQYVabrXj25zPDEBAiNpKAIpWbiAKw
         /M1HS+QDvBSL2aLxYnWlFaPAlAVd5bdkr/Sr+o4HdnYNn4/kRO7aYTC46OCnPGAvngiE
         L3I9XNpci3hKa8V6zCxyXFBr5aOEQd8ZOT1+nWJw8cy/aYjxKbXM205BAuu05REU4X5a
         BdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784011004; x=1784615804;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aCojHCJqKCZD1pOeyWJ1gcjn0kakXpXScxWlytGoI3E=;
        b=NX5HP6tRsWJVTXz8q4x1yqufh7LY9uY/2/XOPdX1Wr1rMWxYdjCmMcAcScm7W5z1f1
         eq7DD1RYbbk/xUke4bO9lruRI3jW7rtpiL9quEUtUiUmzZtAOZmg5JiHpIaYNNaSiT05
         p/qWhercEyWBV4FA/dGMaHieQHHSwTdvfdhDTwT6PH9Ns/J5hBMp2zcKOuhrGk4uU5dL
         qkQgS99aAV+ZqVOiV+yelCTgkl4yYtHP26TxHl6u6UHY/pDHhSft0Ls6n5AwAdiZzfhc
         UFykS+XrpCUrHy0Dd8o/JV88jylzT/NV0gBz5r3PkIMzASrwyRfsc4MEIjktBSckMYK8
         cieA==
X-Forwarded-Encrypted: i=1; AHgh+RpfbN5efckiM5fhm/lIN0Xcu+qE3kX/KgKb85vftfLz9spyJvYobGK7Ko7jL1FZ2YotMAD2W3f8cWNk2I4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxt737MBiPysjy3qqtFgc1ie+LispM4OJHoybpWxZcyiAy5mZKb
	pFoKdGIONOfcucJAmdOJ3CdS3xRl83rMSMUJ/hT4zsRxFgmx8Hb86FpvQ5oEjsKQGcC6JkovKko
	WpQobCCAUDXFr+X8pxHbBSf2Bj4fim7rDYsWMtR6EgQ==
X-Gm-Gg: AfdE7ckuuT3dE5dichjQz7GprSHeN3WyS3pKcdEFMLqLCMVqS2lSiFeYctJaFCFsiSf
	R12i6f+FIYaepnt5nZUbEblZ1JYjVZGffjXdEGWuklcWlnmw867SXzkoSZw1/olQOpRpWfO6+U+
	TdT67IoowECzTZ0y/scdVNnGQ1xn0Rjc5hNWmZXxnCT9G1FJ5lKB0EX3OM8U90/Kyvf9v4V073c
	vboH0JHV9PW+ivIxgZu9N3Cz+cWPfLEmGBR3p0ZigByiFtKguWS3PAGz3NWfNg5YLAQPSwiIuLN
	A3DExmdInnj21kn08uxDQe+DNvkcMtxLCREj3mcPYGML8xqSjoiKPZ4KmQ==
X-Received: by 2002:a05:6000:250d:b0:473:fc10:f675 with SMTP id
 ffacd0b85a97d-47f2dcc0fe2mr11861531f8f.18.1784011003684; Mon, 13 Jul 2026
 23:36:43 -0700 (PDT)
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
References: <cover.1783524645.git.gregoire.layet@9elements.com>
 <28c6e7c493559feffc7e6231b0a2f0b73b7fda41.1783524645.git.gregoire.layet@9elements.com>
 <694c7c37-fb42-4994-93eb-04ed4ae299cf@lunn.ch> <f391981a-29f8-4ed3-b582-744aa47cbe1d@kernel.org>
In-Reply-To: <f391981a-29f8-4ed3-b582-744aa47cbe1d@kernel.org>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Tue, 14 Jul 2026 08:36:32 +0200
X-Gm-Features: AUfX_mw96YChou-o26GCAe3iXMgSxSuxMxN9BrrwvkqSMEY9o4uLAQRa2eH9JvU
Message-ID: <CAFi2wKboRtGWsDWvJjuWXpBQdKD+W4MjZdOdqerWEyWLZDvaaw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] serial: 8250_aspeed_vuart: add VUART over PCI
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, joel@jms.id.au, andrew@codeconstruct.com.au, 
	lkundrak@v3.sk, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 9 Jul 2026 at 07:19, Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 08. 07. 26, 18:46, Andrew Lunn wrote:
> >> +    if (silicon_revision_id =3D=3D AST2600A3_REVISION_ID)
> >> +            rc =3D regmap_update_bits(scu, ASPEED_SCUC24,
> >> +                                    ASPEED_SCUC24_PCIDEV1_INTX_MSI_HO=
ST2BMC_EN | ASPEED_SCUC24_MSI_ROUTING_MASK,
> >> +                                    ASPEED_SCUC24_PCIDEV1_INTX_MSI_HO=
ST2BMC_EN | ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1);
> >> +    else
> >> +            rc =3D regmap_update_bits(scu, ASPEED_SCUC24,
> >> +                                    /**
> >> +                                     * The bit 14 is reserved in the =
Datasheet.
> >> +                                     */
> >> +                                    ASPEED_SCUC24_PCIDEV1_INTX_MSI_SC=
U560_EN | BIT(14) | ASPEED_SCUC24_MSI_ROUTING_MASK,
> >> +                                    ASPEED_SCUC24_PCIDEV1_INTX_MSI_SC=
U560_EN | BIT(14) | ASPEED_SCUC24_MSI_ROUTING_PCIE2LPC_PCIDEV1);
> >
> > checkpatch should be warning about these long lines. Traditionally,
> > the limit is 80 character lines, but recently 100 has been accepted by
> > some subsystems. The exception is when wrapping the lines will make
> > them less readable, but i don't think that applies here.
>
> FWIW 100 is fine by me. 80 is too ancient limit.

Modified to fit 100 characters-per-line limit.
No checkpatch warning.

Regards,
Gr=C3=A9goire

