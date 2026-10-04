Return-Path: <linux-aspeed+bounces-5127-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EDACA5FEC
	for <linux-aspeed@archiver.kernel.org>; Sun,  4 Oct 2026 11:48:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyLPl0gV7z30Sx;
	Sun, 04 Oct 2026 22:48:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:41::d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791114506;
	cv=pass; b=h+2UsIJ0fidUgjKIO8KdogDNfsln1Jh07fQ2rYlk1JyeEb+LkivuSx4WVjRJCPKrDluDTbHVOR2KDRvNr/pwdkEYDV7THV24dKkoIBdPLqFrTzS58v7Rglge4zb2s9e6gXL4nPpHDIU25YkVaUBLmYymZ+6nN2KhlXM0L1PJl6os7NFvzrd2gHlN/pC1DpMHpnXVc8RAclBv6KJs2TyZSC5CuOoGNOPeUf/hGlH66S5l6Gq7JgwkqQxpFEqIHX57djYbK9nsrdnm/a0Ouvu2FvnXFz3pmuepz9FOuf6eQZyEo/PlTErEsb8hvdigSa9Ejmk00xqGZNvvCiRdp628sw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791114506; c=relaxed/relaxed;
	bh=xEcFNNOjf+xrJu4jjq23drU/TN14HXtXueDl9+2Vlg0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kuP0XygNoHdP3POLKawkzQAmXTBW0W5cpMX3wKlmieLxKIxH+L06FqxU1xsmSaJlQK/SDg7nTb9Sj+R9t625a+pvd++i6xZcBLW3VBvGwc61zYW0Ty/E3KABX4fIIig7DW6PbsIhd7SM0gynmyJJYbYcd+GhfiBCTOndqi4NNHSe87J15TqEmWAYGyKqhRQtxHpoLssSds8K32dmvxFuisot5SSJngZ1/C10WGBic7B8XCWZir2uHbIyl5rNFEYFGSb+yg+Re7MJ8WSmFl2cdYWidkqo8zRW/RrTW3n917w5ghozinu5QXO3jW9x0I/kae1EghwP6XfzYsG7vY1YvQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EevZ/ypF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:41::d; helo=mail-yx2-x0d.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EevZ/ypF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:41::d; helo=mail-yx2-x0d.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx2-x0d.google.com (mail-yx2-x0d.google.com [IPv6:2607:f8b0:4864:41::d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyLPh5Dlkz2y8f
	for <linux-aspeed@lists.ozlabs.org>; Sun, 04 Oct 2026 22:48:23 +1100 (AEDT)
Received: by mail-yx2-x0d.google.com with SMTP id 00721157ae682-8aecf8568b6so4514697b3.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 04 Oct 2026 04:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791114501; cv=none;
        d=google.com; s=arc-20260327;
        b=QEm6zKyPkKH3OsBD6mmnBF3gu0QitoZZciWomHaKqqa1tfvEvgkQb20jCq2WXzJB+n
         9ckfLKp4Unq6nFqUwNSz07fc1pRos7qmqPcyEi4JYNXs2na1/qJl56Gyf2jKCbs3EqiB
         MSPjjHBeCqBUiTmtYwuw5laBXiUryhIZVH9MnKJ+LWOseqiWXs+I+GkWtAzCjMKxo1XT
         5+uGgYrYFE+7NRGRk/qjTzXMsSy5xx75P5cd4X2Butea1WO9lp8bZHEulrr4nZWwNzBD
         QzNoiVTkOjKm0i4PKoeWd48fZE7SiOofjWHIV6I0feDZWhMiuJjmth4jP45EopdSbCXO
         9Obg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xEcFNNOjf+xrJu4jjq23drU/TN14HXtXueDl9+2Vlg0=;
        fh=TPMxuPFlXCogfoXf6gQjBZHS2yoHp/IUrYU+F7ENkxw=;
        b=GkgfvdlfwChVeFLp2Ow0ly8JCNSMbUeUM62dMQNHIIQmLSszgPwDZHmHH3FcM3KC77
         TE5XGWkFTH6XBD6HdWoYtzQ8HbCFWTgFvL+tavMK8CgK+pqr1eINuWmct5ECLDlehlw/
         yO8D8FCdMu0eTcw44dyVqOI4hDygAdvfbYPbWUMQ4c/mzKj9D9ici5AIPV5+oHuibqLp
         bKmzpubtUEMlX+RupOBhAFj+q09afgZPyGxwPKHDfWpCdSWiXxqwcoVQ4KdeaJjWYcJ3
         qUyGD28+TErH7CY3ekccGcm1tv6dwOYszjrqqKR78Mc96Ehie51pYRRefcx8A2LCT8NL
         HwDA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791114501; x=1791719301; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xEcFNNOjf+xrJu4jjq23drU/TN14HXtXueDl9+2Vlg0=;
        b=EevZ/ypF1zplq93sMvXm/NmdQ4GDE6ViEDL3nHuzFuPjhd9jVeXuxX6sQhhFpKYlYT
         vKFVH4XAF+xc4G/B4MsmU0rZ8RMwcf8StwOTfWbc/VTypKYM7LLcRvEvRJbdQ/oEyNOO
         J7/ycmCeA047xaVipDxp5kHMYAhnYsdrwEMHi/O55F7ueH13z0lfvWvxdS/3RrnhsSY+
         BcSCuR+B4uX4y8NT8sN88jYno0GfAEncOY4/3B9eHg2tS7dWOpiHV7lNf89HYBN2q9ER
         atXBPdLjfOjZT7cpCl0A8GKWEWFWsN3kqcjRNKtkgOALw16YrfWo9I6iPhpb5ep5rGY0
         RYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791114501; x=1791719301;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xEcFNNOjf+xrJu4jjq23drU/TN14HXtXueDl9+2Vlg0=;
        b=jlMBxo+Sc9rrb8r+lfZRFx0Me+hytI3+nGIxw1JefsYxy9w8NW8aMPGMVjnz9Awgac
         u2LlJQZtOvRNgtkIOqdNBjjLJcdGjr+6vKw/KgxjAdbxlqaf+hs1bCa+R51vffX+kWaD
         ssU7kOBS9xEhLKgNKA/2p38CpI5eeTTeAFyUvrEg5gmRwMTP9YQ8PgJe5nr3L3yAt40N
         KjmJxsxWtvDJVJzhTErZXNGru4zYfOgjOT3EJ7sfqhrQ9y9vSNuYP6rRonteD2e4WitR
         Cmb53sywazVFI48XDTnVG26RYNkXL7HdDLOedJVxpqPlIYZ79KUGqLaCRrZkJvPGJjXC
         ow6w==
X-Gm-Message-State: AFq9FYIV+IPkPTz39kHogkhz9s0ModvPPrBT0GPezwkcaEBNbzllhc8m
	1Pmy4xdyYqH8EZyyPUXzOVlQpeb1hQqiunIhHs0jKuQ57ksH3mUuSPaJ+i2N/UxTsMBvTIbQYkc
	xC1CWhqVoL5P7falNMpsY3bfW3+XMhxk=
X-Gm-Gg: AYBFou0SWgmYLknnEvRItp1YBmODloaXSFB065tAZ/Qnkfpu6b/FsyUbo7v2mjqPDLH
	oU5LhvKsn0TWZihV60vWyPiNCd7jgSNKEZYu5w14GrW0LWYOeswk1H41hcL6u1pjYoQsCEAPsCO
	+RTa0usmJ7XdvzSfMVmEHWeQKbdnyNc1W/qr5tIY0tY/pkrtcpF1glRWn7XVWblzJKuLzF8ZzjV
	+96SPK8/m6M9nziIFGwaicXYldy2RNIKqUOfXlXr3mjTGQxDmP6XuV2C23q4sdpjXjftj+7TGJc
	iU7gJUZCH9Gs2QNLa9bUloiKDV1rAYEj4swq0BdZuZ5ckWYUskAXhLn8P/WXArl0hhGm
X-Received: by 2002:a05:690c:9990:b0:8ae:17ba:df03 with SMTP id
 00721157ae682-8ae3add6500mr24577497b3.64.1791114500851; Sun, 04 Oct 2026
 04:48:20 -0700 (PDT)
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
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Sun, 4 Oct 2026 17:18:09 +0530
X-Gm-Features: AclHuK--qH85BIZtoMJyg3lILYRB1sLcVJWp98pczpJ8Wky3hLgnsWW47W5LklQ
Message-ID: <CAMFFDGja4JnRHAUQTLHAStZbYM0GyKWVDAOFENCyrVc3AmV3Hg@mail.gmail.com>
Subject: [RFC QUESTION] AST2600 GPIOP2/GPIOP3 pass-through and gpiolib ownership
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-aspeed@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	openbmc@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"

Hello,
-> I am investigating host power control on the ASRock Rack B650D4U,
which uses AST2600 GPIOP3 (GPIO123) as the host power output.
-> Vendor firmware enables SCU4BC bits 27:26 (the existing THRU1
function) around the host power pulse:
  SCU4BC: 0x02000000 -> 0x0e000000
  changed bits: 27:26
  GPIO123: high -> short low pulse -> high
-> The upstream THRU1 pinctrl group claims GPIOP2/P3, so selecting it
statically prevents x86-power-control from requesting GPIO122/123.
Without THRU1, x86-power-control can pulse GPIO123, but the host power
circuit does not respond.
-> What is the preferred upstream representation for an AST2600 GPIO
pass-through pair that must remain controllable through gpiolib? Would
a generic Aspeed pinctrl/GPIO extension be appropriate, with a
documented DT property identifying the pass-through pair?
-> I am not proposing a board-specific sysfs interface or direct
userspace SCU register access. I would appreciate guidance on the
correct kernel ownership and pinctrl model before preparing an
implementation.
-> The AST2600 datasheet defines GPIOP2 -> GPIOP3 as a hardware
pass-through pair. In pass-through mode the BMC cannot control the
output value. The B650D4U vendor firmware changes SCU4BC[27:26]
dynamically around host power control.
-> Static THRU1 pinctrl claims GPIO122/123 and breaks gpiolib.
Ordinary GPIO mode allows the pulse but does not route it to the host
circuit.
-> What is the preferred upstream representation for dynamically
switching this AST2600 pass-through pair while retaining GPIO
ownership?

Regards,
Prasanth Kumar Padarthi

