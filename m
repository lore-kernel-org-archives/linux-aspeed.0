Return-Path: <linux-aspeed+bounces-4208-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C63CD8CB2
	for <linux-aspeed@archiver.kernel.org>; Tue,  9 Jun 2026 23:41:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZlmF2dXFz2xLm;
	Wed, 10 Jun 2026 09:41:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::434" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781012073;
	cv=pass; b=d74uG8wjYPBOJVGa6hUW54cqA3KZrqfGcznWnErzVb+KtgHSwuMKHlsq/A+STabz/qYIii5uocNLxINrWr9Pl2MZP+RzwVBX6VqWA1pRGfXKcRqNxaa5JIpvM0smCWhYfHi1fyDFdYURtrxj24Le35yJ2Y62NuhdOyrG8+/2HQpRLipfBg9ayvpMiDnP0eALWAnc5feOhWPW1IwjKkjljeMe/xrtTKGK4Uz1jFU1cw5o0NRdu/0r2VC0bdd6xIWtf8njhNvTf4vz/YS1KEfhrWs9lVMxwdhzq/zX2yY2FOI1AsnGJynQ8EALtPkglyoBCeaF/4vW8mqD8VVGcAvNAw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781012073; c=relaxed/relaxed;
	bh=dnx5Tp560S/h00zHw7AF+ZWXuzVRsTvpYdbuKDqUzGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MV89uF9+vHIuIt6U/bDpQJP2cXPBHspPClOgLMgEalMJ3CsDaRh40ClbZc1KLtQvDF8lTtpWzkq3Y1B3/iYbti7Ji/Ar0Nc1dm1ZkfaCvmLlY1Zy/RXsBRY53qnWFtEL3cHDHM2olTSP3U14BNMsD8bq6S99nN/xSj3odNItVB2NMQa62+lzOY7YE2oDqHT9AmtPXf8f1KtoADqDaDM6nRaN+JB0jT457CVufbCTr/sXY/6xL8L/C7krvfLnoBKbTmGaxsLHOGIWyBHlZ+hOuwVGOTpM79g8G0kQJUK1TMCL5wxzKUjWb8uwPMoQejNzIrsL0TRlB4ftq3jK5jewkg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=ZipGjzBr; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=ZipGjzBr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZVJ750rdz2xll
	for <linux-aspeed@lists.ozlabs.org>; Tue, 09 Jun 2026 23:34:31 +1000 (AEST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so4091947f8f.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 09 Jun 2026 06:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781012066; cv=none;
        d=google.com; s=arc-20240605;
        b=liGyk2CrMBBDbucZ5PCMDWA/Aj2H/uL1MtTLstRT3NPAtZVEI8dgwcz4uqsytgvRgL
         +HrvB7WavbXkEaOwae//GG1Ha/spVJqeaW4YIOrzd766Q6TV6kAfp4FQaqb5rXLI70EQ
         vZOzhBf+U7xXHWn6/VEKVtyGX4/xUAqQUkD9+dbuKnwowz8TKsCmElBfBeXd2ly22XV2
         BrXrOHz4YEV4tyoIlAJAmF5akL8+wyp4rlUJYxzku12hzCdi6hLs9N84iEeAhQnxkmjf
         QhAwHy2gaNGDKRiGbaIMmU8Z+KESpmw4ntfzGqZWltzytMPyauSmbGp1xVYtmStU4ytZ
         mc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dnx5Tp560S/h00zHw7AF+ZWXuzVRsTvpYdbuKDqUzGM=;
        fh=VBNl9Gsksbt7d07zyH2G8aR/yCeuha4AOlnuavqfu0w=;
        b=IOapq3sVAJuQV3F7Ry1K1BMOFBlowT+FVZLrAuIE3GIm+Vxy73PvGsPCmsgxXPs9u6
         AsV4fIvrQ3YGN1nPfhTqowG1YjGFjvw5NbB3e2Xqu3KeMpI0YX7qQQwVUOqtXNQSoD4U
         RltvQCy2d1CdjMPPt/zkdrWgLMRYF2fq12rTnAZWZxWYFt9khHOCYLjdP1mFk4/7Zz28
         7FM8Wr5pJDeQw3ZXA1YTsdTcym48BPrYCr4P52NoNUm+qgtWk/YNtprUsmePH41eIbI5
         OHpTOeqZHm+xQPM3I6xIvXZqQDXCcSQi0ZzmbGRTXH9s88MvMQwoGJTgTHqxbKRpZgUP
         EvLA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1781012066; x=1781616866; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dnx5Tp560S/h00zHw7AF+ZWXuzVRsTvpYdbuKDqUzGM=;
        b=ZipGjzBrgqq0rpSEQLPGBHU6RjdVNgvcyRxoVa3cc7ejK3d3HY9BuAsn4qnFUm/SkA
         gocxdyltcmouSoNqTTE5T84yH+ACvstyzEI6UeOuBpX1Ed/8hGU3KMcuATUQbxUWqkE+
         tcBzHnkcQzOZLCyOC0q5aqD3MfcF4IlnM1wB+2qPyuC7kPeLh8vAW+GXCkh0sEQ05QfQ
         apEGBMIpHcwdDTcP0SrG5f+oFnmEZtq6XEEfuRzTuvDy/wIRYDYkHy+H1pFgmUid4DH/
         WqzPI3K24SyQ/xsgaBMt490BB1FW8LAHiUthSd4FNPsLoZzfmV06QMPaguPXeqMZQNyC
         lDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781012066; x=1781616866;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnx5Tp560S/h00zHw7AF+ZWXuzVRsTvpYdbuKDqUzGM=;
        b=EgTPpMC7Ya7/YjtOhodv3lV2g9Ale3GaFwjw5+kFGd6I5nvcADl26Rt+2Hb14pLFJd
         A0g4g9HuiIz76AsCE13Tt5s9IpGoTHGhX8Fxhzu8WhqEDbmBaBfjbflwJUt4QN88eXkv
         +3KxqsxIJnI7Z4tGwH4rFnqUwgm5NtWNdChqwYtryDL1QkBIkmJZN+a+GebOUqq3LdKH
         Cq/W/Yc4+0q0Ac65kVtSlET0zCC4D3ldw5E0UN0Ao5c2e7rU89RvWNTlkhhOqogp+fvE
         gOexX0FCY+8vG+ZSLCerctJRxVN9Hl4xY46eOu5tTTEOgz43chN3D1knrYgp8yRQTl0a
         Vz7A==
X-Forwarded-Encrypted: i=1; AFNElJ+5SCnq27y8JbChOZPl4+pT8RoQMRuvhgpGPhLnpf1aMsWg94OHAOLemYiKVG3ex5kXxSK3LLrgS538ECM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyVtaTOKnVa+2Ng1ArmQ+RsOtPHVRhQD5AHYkKVw3P6ZzKVcgDJ
	n+y6Fk3Nso5kT1ExT9cMOOyvhRlIVF7MUkS1at2cHZZ5IwMBNP6gPMfNmJjrVcGjCyuV6bYnN61
	Rz1U6ZoQGB1hHYyqV4/Pskfi7QaYJhsc1G4OfihWJqg==
X-Gm-Gg: Acq92OFAt3Knk9Dtgb093pXo5KnMdn5mjUTBtMfYObbgfgKvafRP3ZKAEbv5FTuYlbX
	CfrZWr0l8+a20k4Z4fXz7BLxcEXI2BuS2DDqz6x9J8FDazXvTAYGv5vg8Eu0ViE9+sHAYyKQlWL
	wMmTvM7PyAdNV7QAtXp+fYybOjEVrOj+gdmZmGgtPDdmGMQzkc4oSIOb6wg+Y+0T8324Y6WRru6
	/+57qBkaGmvbBI/0WJePzzpT/HqzcSLouzqXEakI1i8eWsRfIQ0gEcd9XsRYv+xYAEMgtNSDAtL
	ee4fSsu1nugTIWn5XNHwzAzQfPtzmrvoWYZGHKCNhMxtEDK1+/XqYaKcdk8a+8AiJCsMSO+/hDJ
	Vu9hc74Jjzlm0jA==
X-Received: by 2002:a5d:4d4c:0:b0:43d:50c:6f33 with SMTP id
 ffacd0b85a97d-4603060b001mr23218990f8f.26.1781012066371; Tue, 09 Jun 2026
 06:34:26 -0700 (PDT)
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
References: <cover.1780409151.git.gregoire.layet@9elements.com>
 <cover.1780929570.git.gregoire.layet@9elements.com> <63654bb5-c246-41c4-bb7e-5bfa23e59f2e@lunn.ch>
In-Reply-To: <63654bb5-c246-41c4-bb7e-5bfa23e59f2e@lunn.ch>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Tue, 9 Jun 2026 15:34:15 +0200
X-Gm-Features: AVVi8Cea43-8TO0qQAyqeIGR0QvD_re8rhGrQhZ5B93W67dWApUxz4ngQN1Zqg0
Message-ID: <CAFi2wKYOAotiezepDqaR5PZDqDaPKKDfAEnpx5EHC0mL39hy6w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] soc: aspeed: Add BMC and host driver for PCIe BMC device
To: Andrew Lunn <andrew@lunn.ch>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, jacky_chou@aspeedtech.com, 
	yh_chung@aspeedtech.com, ninad@linux.ibm.com, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> From the replies i got the host can access anything on the LPC bus of the
> aspeed.

The PCI-to-LPC bridge only decodes some addresses.
In fact, only the following are accessible over PCIe :
- LPC Channel 4, which only supports the KCS protocol
- The 2 VUARTs
- SuperIO-style Mailbox

Regarding the KCS interface over the LPC channel 4,
the BMC driver in this series does not set this up.
It just needs to be activated in the DTS.
Then the host can just start the ipmi_si driver with the correct address.
This is the intended usage for IPMI management and is part of the normal
trust model of a BMC-managed system.

Here is a summary dump of the PCI BAR1 from the host.
The BAR0 is only used to expose a BMC DRAM region for shared memory access.
This v2 removed the memory mapping so BAR0 is not exposed to userspace.
The BAR1 is used for the PCI-to-LPC bridge.

Offset          Size        Contents
--------        --------    ------------------------------------
0x0000-0x00B7   184 B       Blank (0xFF)
0x00B8-0x00BF   8 B         SuperIO Index/Data port, mailbox config only
0x00C0-0x0E87   3528 B      Blank (some no decode 0xFF and some reading 0x00)
0x0E88-0x0E8F   8 B         LPC KCS4
0x0E90-0x0FDF   336 B       Blank (0xFF)
0x0FE0-0x0FFF   32 B        VUART1
0x1000-0x2FFFF  188 KiB     Blank (some no decode 0xFF and some reading 0x00)
0x30000-0x3FFFF 64 KiB      Inert region: 256 times repeating reset-default
                            values, not affected by mailbox activation,
                            not accessed by this driver
                            The datasheet doesn't explain what this is.

So, the host does not have arbitrary LPC bus access,
it can only access a small subset of it.
The relevant peripherals must be explicitly enabled the PCI bridge
to be activated on the BMC to be accessed over PCIe.

Only the specific interfaces listed above are exposed,
and each one must be enabled by the BMC.

The security implications are limited.
The host side attack surface is bounded by what the BMC chooses to expose.

> TPMs are often there, but does a BMC have a TPM?
The AST2600 chip doesn't have a TPM.
The Asus IPMI card doesn't have a TPM module either.
If a similar PCIe add-in IPMI card has a TPM module,
it will be accessible to the BMC via the LPC bus.

But this will not be bridged to BAR1 by default
as only the above-listed interfaces are exposed.

However, the host could access the TPM with some specific BMC side
configuration of the PCIe BMC Device (PBMC).
That would be a deliberate BMC side firmware decision or bug.
This driver doesn't expose a BMC TPM.

