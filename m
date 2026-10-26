Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76342606A31A
	for <linux-aspeed@archiver.kernel.org>; Mon, 26 Oct 2026 22:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DBfePErf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jD7vY2YvBz2ySk;
	Tue, 27 Oct 2026 09:43:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::62c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793011080;
	cv=pass; b=Q7n0+jyEWjk/i2ZtuGbJ5Xy7okZsqJOrzxnXus4wfEs5zLncWS2DExLHGknSuT8nwarvEJoATToUFw0MbxpI1BsPY3Ul9QlJa9tAkmXvDROcHFjdFM9IEitkICFq4mnW9cFy2khkTdcoRxLb6ifrdmsnfXQz7dhGQLyAXbAds+HHPIFGIU2ozfnjlpUEdJyQJ0PSM6wArtK2dZRVmPHyKcF3m9ACEmJsm21HQfKiFA92e2s11LI+w+R9Pa0WlV9ukCKpkT3bV74Fc1T1MgrBaoNzC4HMQtL8Robjv23A02CTkjgfUrD+0OiMgT8Mb8xtRxy+sSUrewleBtjd23/w8w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793011080; c=relaxed/relaxed;
	bh=nyoRHdpnLelYoEsc3Y/xoVZUSJAqYxJf2UwQ17UQ4oM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZvCiktk9D2hLfkGBc4xbUdhO+NULxnzwIOErIWbiF3jbTVOc6VwIjt7jcOqDMzSb3HA8/qavdA59j8uqNr+z3cU8BJ0/cBrT+XKRuL1q5qVOFK4W7xoh5ZxWXsGKH78h5aVIwh/ZBfSClQDK81Hxz72uXg5kgSNWo8lhiFO+IfeDLL43Eko/tV2aLHIiR1aYoj+rb7hRf7CqRgZgsJXz1Ow69SzLLvUk6npE8D0Npo2+N1I0ZuHPOK0lQIZeqioRcbTf++lBqX6ss+VDu+xO9ZOQ+bi3ovg/9CcVNY+NQaaP24x9JXRx33LK44Vinhh18hn4JoG9Yix4pePa3jg+Zw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DBfePErf; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=kavyamadarsh@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DBfePErf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com; envelope-from=kavyamadarsh@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCqpF4F5Qz2xM9
	for <linux-aspeed@lists.ozlabs.org>; Mon, 26 Oct 2026 21:37:56 +1100 (AEDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so389955266b.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 26 Oct 2026 03:37:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793011071; cv=none;
        d=google.com; s=arc-20260327;
        b=acutNzxeHvZSVhoCPSRh2IJaoCpXFftBQiE+8U9ihHjUvZVi1IZV355a96fZEynCcn
         /fa1TQ6TlDspqR6VssivXlAx8am9Kjy6Hb6CesgY24a6bEh47uikzq0IMK2Nzwz1vHc9
         IWuQPMDOOPKgOl7tRsc+bdaVhjcmIs/Z794/pmwtm8NWJVA+h7i4dXR1lLiYtjRrdp1L
         wOprmcZJoYaMxCwX6hxkI35KwOw3R6yBDqlx+w9snI1PtZLYuMbzMcQkP6IymxlftyJy
         XLfn/OAIc8Foh4+Telxc5WRNTi4PybwsNlTxXTrJgXsoJ4mht9siHmR+FUFkXLc1mb7d
         VZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=nyoRHdpnLelYoEsc3Y/xoVZUSJAqYxJf2UwQ17UQ4oM=;
        fh=NXhTl1i4bUqWtU9ZYEwdUALr95Z3c7b1eKTXSJemeCg=;
        b=fQz78CsPmdx8Pxnuf+OVmOUtEOW4HLFi4AP3IzhTOiwNhd4XsqL3qK42GXtBppVmvX
         avgVjPNI9u4k8/j5u0EZWdccAoEWROs5DKW8ABzTHCSESSHl8pujPVSv0y6h0jbgym6J
         R4nKBI50H/TuSoJyKwrmCvKXoyZQYsWDcUc488nNfbI6ZoguuyHvEKp1PzEsRb6QK01v
         0WbuKJ3LVx0Lih+dJKZOVUmV8X9itrOYAmvWq3gYEIalwGhZNV+fV8+Q6lqlh2gSowax
         NhGm5cx4orFm/zG6yZhfGqOy6y3QLvDTUOxGHopBEdqsAB9zX6qixqYBW+aDuvBWLqAE
         pHiA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793011071; x=1793615871; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nyoRHdpnLelYoEsc3Y/xoVZUSJAqYxJf2UwQ17UQ4oM=;
        b=DBfePErfa7NW2RtazIkr1eb1meuxPCXi3HHBbU+uHshDRO+Bg18GoiJdMJGTAAzBST
         v/TW7kX90JoaPGqAzkXaQgAQHX9OQ3AVafSL8W26gguHVEklKFsf4fnryYAwDETI5DlI
         /D7mBBYy+q7udFwAtWg5QoXBIGon8nBAtx5sMXhJkhij64f9L8jNkAKTqr6cepwu2js2
         NYQgwqjUh2ASBiSa8aAGdRhHoJdmJ9yfBW1o1chghmo2dHF0GqUBlZWQbbPxvOq+WeOA
         lSfZ3BPetQWGcbAplbIlaDAnolhXDNYuKg/CbR4WDOixJrMdhNz/M/o4yaCEE305oKKJ
         2TQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793011071; x=1793615871;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nyoRHdpnLelYoEsc3Y/xoVZUSJAqYxJf2UwQ17UQ4oM=;
        b=Jrw1Oo6BRymA8y52tSNZhNBsNV4Z6LIUy1gYGlKH9BwBTkzuWN279kFTcq2ZJj19Se
         EtlK89SL/RxqT8UZa5sRenXAsa+25pQJXZrwdHSJqLjNX8tmZcdsi+hxmopup49+ww+8
         8dP/IFE+zwlwQaxOb3XrgkPh+lQjPikYRe3RJfLnK7f3KaS0TUK5kLp5K6SDnyDVz1Tl
         3lj6Vu+9Ck1e70X9UTDCUKnKmLluVunhWVD7zMGIGfV8pNk7LihkOgOBNMLtrAtPRRcP
         6Ec7FQdJaP+1rnytLOXqhgL33+FNAbMsfgDASGL0qXU+++bVWxc0p0HJ8ze1x/RstcFB
         twTw==
X-Gm-Message-State: AFq9FYKxZNFId/LOhzpMm01neMNaF8yiuKwdiW3YHVw8iGPM5fJcqZFA
	YBZsuffTTw/5+Nn+qyb/MkmV30W7iWKK05wj3J0/OwAnCRM25XRq30dqFhUGwPwXhwKgsZlkW+R
	z5RszRselZWpdSUJt/E0BhXm0nW4SXyk=
X-Gm-Gg: AYBFou1wKuI2IiF2hkD91LBBy/HM9ZhuZCLaNKlI1rl0ZSAcSulnux16OTYf5Jp/ke5
	KYX+qx38BYksZb6J6x9dV45ZN7QrmGVif2iMxz8TFW5OrLoIp9o0c/YGkyTkuf7Qp3sUhU5PYCd
	65CQlcA5R3GciJX7ciZqvT9IupuNexWUccF4B02IpIoeAUx7QoistDaEHrCWR/G7UYs/DkiQcIq
	iYwzrhPipynaAPDCykg1NGWYaquEkOWa9KCH5/dg+mLibnOIJ5ifmher3fqV7sPmdeMIRHbvsfs
	3Etd0AKg9HTSFXptkRnuliha9dXJ6UQRLFG5L9dVYXp7/PywEG6UUOnG7rRk9HWlbQVYPhzt1pU
	o7srWGMFyM+B36xMEHDfybeASwxVyLXySPF/N
X-Received: by 2002:a17:906:9f8a:b0:c40:560a:462 with SMTP id
 a640c23a62f3a-c46bde78972mr786509366b.32.1793011071150; Mon, 26 Oct 2026
 03:37:51 -0700 (PDT)
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
From: KAVYA M M <kavyamadarsh@gmail.com>
Date: Mon, 26 Oct 2026 16:07:19 +0530
X-Gm-Features: AclHuK8LqQPbQnLPaECa0WbeYBxRUpNvgzNAC0qcUR0XS0yIEMNnKQBPgXr-ddM
Message-ID: <CAD_a9macSzuBsmmoLu2Cu1doLADvcpASFi-6ADnOvmMdgDEfHA@mail.gmail.com>
Subject: [OpenBMC] Guidance on Getting Started with OpenBMC and Choosing a
 Development Board
To: openbmc@lists.ozlabs.org
Cc: linux-aspeed@lists.ozlabs.org, Prasanth <prasanth.padarthi10@gmail.com>, 
	andrew@codeconstruct.com.au, changhuang.liang@starfivetech.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jani Nikula <jani.nikula@intel.com>, 
	Vitaly Lubart <lubvital@gmail.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Usyskin <alexander.usyskin@intel.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Breno Leitao <leitao@debian.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	James Morse <james.morse@arm.com>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, Dave Penkler <dpenkler@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Mukesh Rathor <mrathor@linux.microsoft.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Alexandra Winter <wintera@linux.ibm.com>, Julian Braha <julianbraha@gmail.com>, 
	Karthikeyan KS <karthiproffesional@gmail.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Joel Stanley <joel@jms.id.au>, 
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Oskar Senft <osk@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="000000000000f96f6b065ebbeb12"
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000f96f6b065ebbeb12
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello OpenBMC Team,

I am new to OpenBMC development and would appreciate your guidance on
getting started with developing and validating an OpenBMC image for a
server platform.

*I have a few general questions:*

1. What hardware documentation is normally required to develop a reliable
OpenBMC image for a new motherboard? Are the user manual and BMC reference
schematic sufficient, or are the complete motherboard schematic and
board-specific signal mappings essential?
2. If the original BMC firmware is available only as a binary and the
motherboard schematic is unavailable, what is the recommended approach for
identifying the hardware configuration and developing the initial image?
3. Which existing OpenBMC reference platforms are suitable for beginners
who want to learn the Yocto/BitBake build system, device trees, machine
configuration, sensor integration, and required services?
4. Which hardware platforms provide good support for testing sensor
monitoring, fan PWM/tachometer control, Redfish, GPIO, host power control,
and power sequencing?
5. Which functions can be tested in QEMU, and what hardware documentation
and recovery facilities are necessary before proceeding with physical-board
testing?

*Request for Guidance on Restricted BMC SSH Access*

I would also like to understand how to access the underlying Linux shell on
a BMC when SSH access is restricted by the vendor firmware.

For example, some BMCs provide SSH access but expose only a restricted
interface, such as SMASH-CLP, instead of a standard Linux shell. In such
cases, what is the recommended and authorized method for accessing the
underlying Linux environment for debugging, inspecting system
configuration, and understanding the running services?

Are there standard OpenBMC debugging methods or configuration options for
enabling SSH shell access during development? If access is restricted by
the vendor firmware, what documentation or permissions would be required to
investigate this further?
*My current hardware*

I currently have access to a Gigabyte MZ32-AR0-00 motherboard with an
ASPEED AST2500 BMC.

I am considering using this board for my OpenBMC development. However, I do
not have access to the complete motherboard schematic, and some
board-specific hardware mappings are difficult to confirm from the
available documentation and original vendor firmware.

I would appreciate your advice on whether this is a suitable platform for
learning and developing OpenBMC, or whether a different, better-documented
development platform would be a more practical starting point.

*Request for development-board recommendations*

My budget for purchasing a BMC development board is approximately
=E2=82=B95,000=E2=80=93=E2=82=B910,000.

Could you recommend a specific development board or server motherboard that
is affordable, well documented, and preferably has an existing upstream
OpenBMC machine configuration?

Ideally, I would like a platform that supports learning and testing:

- OpenBMC image building using Yocto/BitBake.
- Hardware sensor monitoring and integration.
- Fan PWM/tachometer control and cooling failsafe behavior.
- Redfish and other BMC management interfaces.
- GPIO, host power control, and power sequencing.
- QEMU-based software testing followed by physical-board validation.

My preference is for a platform with an existing reference implementation,
accessible hardware documentation, and a reliable firmware recovery method.
Used development boards or server motherboards would also be suitable if
they are available within my budget.

My goal is to choose the most practical platform, build and validate an
initial OpenBMC image, and gradually learn the hardware integration process
before attempting to flash a physical BMC.

I would be grateful for any recommendations on suitable hardware, existing
reference platforms, documentation, or practical guidance from developers
experienced in OpenBMC platform development.

Thank you for your time and support.

Best regards,
Kavya M M

--000000000000f96f6b065ebbeb12
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello OpenBMC Team,<br><br>I am new to Op=
enBMC development and would appreciate your guidance on getting started wit=
h developing and validating an OpenBMC image for a server platform.<br><br>=
<b>I have a few general questions:</b><br><br>1. What hardware documentatio=
n is normally required to develop a reliable OpenBMC image for a new mother=
board? Are the user manual and BMC reference schematic sufficient, or are t=
he complete motherboard schematic and board-specific signal mappings essent=
ial?<br>2. If the original BMC firmware is available only as a binary and t=
he motherboard schematic is unavailable, what is the recommended approach f=
or identifying the hardware configuration and developing the initial image?=
<br>3. Which existing OpenBMC reference platforms are suitable for beginner=
s who want to learn the Yocto/BitBake build system, device trees, machine c=
onfiguration, sensor integration, and required services?<br>4. Which hardwa=
re platforms provide good support for testing sensor monitoring, fan PWM/ta=
chometer control, Redfish, GPIO, host power control, and power sequencing?<=
br>5. Which functions can be tested in QEMU, and what hardware documentatio=
n and recovery facilities are necessary before proceeding with physical-boa=
rd testing?<br><p><strong>Request for Guidance on Restricted BMC SSH Access=
</strong></p><p>I would also like to understand how to access the underlyin=
g Linux shell on a BMC when SSH access is restricted by the vendor firmware=
.</p><p>For example, some BMCs provide SSH access but expose only a restric=
ted interface, such as SMASH-CLP, instead of a standard Linux shell. In suc=
h cases, what is the recommended and authorized method for accessing the un=
derlying Linux environment for debugging, inspecting system configuration, =
and understanding the running services?</p><p>Are there standard OpenBMC de=
bugging methods or configuration options for enabling SSH shell access duri=
ng development? If access is restricted by the vendor firmware, what docume=
ntation or permissions would be required to investigate this further?</p><b=
>My current hardware</b><br><br>I currently have access to a Gigabyte MZ32-=
AR0-00 motherboard with an ASPEED AST2500 BMC.<br><br>I am considering usin=
g this board for my OpenBMC development. However, I do not have access to t=
he complete motherboard schematic, and some board-specific hardware mapping=
s are difficult to confirm from the available documentation and original ve=
ndor firmware.<br><br>I would appreciate your advice on whether this is a s=
uitable platform for learning and developing OpenBMC, or whether a differen=
t, better-documented development platform would be a more practical startin=
g point.<br><br><b>Request for development-board recommendations</b><br><br=
>My budget for purchasing a BMC development board is approximately =E2=82=
=B95,000=E2=80=93=E2=82=B910,000.<br><br>Could you recommend a specific dev=
elopment board or server motherboard that is affordable, well documented, a=
nd preferably has an existing upstream OpenBMC machine configuration?<br><b=
r>Ideally, I would like a platform that supports learning and testing:<br><=
br>- OpenBMC image building using Yocto/BitBake.<br>- Hardware sensor monit=
oring and integration.<br>- Fan PWM/tachometer control and cooling failsafe=
 behavior.<br>- Redfish and other BMC management interfaces.<br>- GPIO, hos=
t power control, and power sequencing.<br>- QEMU-based software testing fol=
lowed by physical-board validation.<br><br>My preference is for a platform =
with an existing reference implementation, accessible hardware documentatio=
n, and a reliable firmware recovery method. Used development boards or serv=
er motherboards would also be suitable if they are available within my budg=
et.<br><br>My goal is to choose the most practical platform, build and vali=
date an initial OpenBMC image, and gradually learn the hardware integration=
 process before attempting to flash a physical BMC.<br><br>I would be grate=
ful for any recommendations on suitable hardware, existing reference platfo=
rms, documentation, or practical guidance from developers experienced in Op=
enBMC platform development.<br><br>Thank you for your time and support.<br>=
<br>Best regards,<br>Kavya M M</div>
</div>

--000000000000f96f6b065ebbeb12--

