Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7BD606A321
	for <linux-aspeed@archiver.kernel.org>; Mon, 26 Oct 2026 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VkVC69Gh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCrTQ179Pz2yMP;
	Mon, 26 Oct 2026 22:08:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::112e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793012906;
	cv=pass; b=C4Qu4ShpmcC/C38TOLYP8bQU1HOaGjYIKMRGLTijSx6a00L0+OSafdHFNx2NB4U0wPCjKTv61UjmLZZZezLmQLOkhyn/F8XlMUElkaHUz8dPr+Ng7W3hDcy/dtxb1efduNnr2Drfib/Ghfqfa1mfgChu6Dt3Ocja8W7bA6TaumraDvRsZNwN7PHqOTCQio0Uq7as/9SgMlSMTiP9PkT0JLc1BjQ7JfLPYDaIirXIdwQTII3JWcsv2TP13v+iO442AtZoSaCviwM8uXpJZedF8Rk0MakHQ/mHtvJCCdO3hJrC1JCQ2ZAx4kFVLa0kul/Cjdp7I/rkp7Hvyk4Yjr+PXg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793012906; c=relaxed/relaxed;
	bh=tD0Lls83Il+mQLYthxWqSv/YIy5kSUrF6JCqhkv/8Wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZexmsiYq1MQv2dC1ouOARS8VNXVBIT6xWHcUWoeIJJtfpQSFP4KxDYBis8wxCoyXTiLax4sV56eyDWARJZsK7YNf38L/WsSkjt5nzk+GYhe9IMwPORLmYoqFCn136WjX/GdP2gz0aCugBB5QwSPbC3aRj2hmylOTtlOprhO0Ind3uzLeyAB7Kp/NLt6qcfCQ/18vsvlh0h/VIa5gYcOnLFHUOlAtstb2KQhsY060bqL77DkGw+Xxgpqm4qmeHTJcuWG9nGijYHr3T5Fsvf/EEk5FABIMv4FpuQBX7LjV+u50fZqrL0YypuKqukL1jGIH6+twKqEF6K585to5pavyA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VkVC69Gh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VkVC69Gh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCrTP0qs6z2xLt
	for <linux-aspeed@lists.ozlabs.org>; Mon, 26 Oct 2026 22:08:25 +1100 (AEDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-8b10d24345dso25041917b3.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 26 Oct 2026 04:08:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793012903; cv=none;
        d=google.com; s=arc-20260327;
        b=s9Hu6pG4xyJDim1wGvLtW2KPobsK7Dx4qX85eTT6heLyMK2C1Vo4BYTOZh164LFTBc
         rxBeo+Cj9LJG77ZjZfxOYfS19MS5M/WSYlruF9xxM3e+fMOkyTxroSne4oIJP6te+VFL
         rl94IaTNtoqVBw9FOMtdkseC+DdLbR6wGBlRUdVYjL2Lr1ExxpcdcjrcEjffI7TrlXS9
         DV0BmfFziXBGUWazuaff4af2XRj/klU0C5SekvNc9C3WBwaDwLWRHxwcihoomyHduG/Z
         9wK4zkxeKMhlHdrN9V+iVKR7usmlGkKa7TH0oe09l1kO5lyqTnW3usEyo98+vps6Fp4L
         /etw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tD0Lls83Il+mQLYthxWqSv/YIy5kSUrF6JCqhkv/8Wo=;
        fh=4gGAqT1bGQtqE6nTNPtDbed/OAM+El+0DnspWPwKxeE=;
        b=ctUGIHUx1mhhPLFpfVJYLN+3t4S6wG/8bhUrZ1c7W6Oc295C/7+B64ScfcnvbtPR/F
         2r3mUiqSQNZP4vauxm4ZqdpC16HryQpjYJk/XqssIGohcXJl+UO2s1IRg/NDh0q14I/L
         DYlK+knpW6P6PPjYGx9xpQWyRfjlFGi1gPwXY3bljxMGzYT0UkZINzpA2Dn8/G13W/cX
         ZxpOGOHgSiSzbSr8DLTuU6WLQpkqlNp3B6Lh/uGJWVr6Xapb6JQauF18Bn6EnjIPbJsL
         KOCOispWgZIFdRsgN7vzjhiVPou8US8KV+X0vkBGjoiOhb+/rXDVDkTFP0eahlip94o2
         G/bg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793012903; x=1793617703; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tD0Lls83Il+mQLYthxWqSv/YIy5kSUrF6JCqhkv/8Wo=;
        b=VkVC69GhGnQSUuuaJRML6uzfxXefuC7GQedx95rb/h51Gp3nTW2zbJ609g6rLhu56T
         6VKLO8IcliZNW2I0b0kQUgfwnhadRsWrCee2z2AakblfJfYxbcHpdOuU2fLzOYjXEiEi
         kWowYLbcqZD0HENKKZvgBxgcCZuWG7IjIC2JVMq1jRf8+CV2ZW7P+PaHNLblqN+awF7K
         /mfeG3gN62GEcuG+5G4LqRcihaUoaNODamq159rS2yvkk8nBLyc8LwbviTbXnz1cf9b9
         XKY2eReIam6PtBdtIarFJZnCLwlYWqYSy/geiG41UNz3I9YM5uFU6iilcxcQKxz6r/Fe
         FQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793012903; x=1793617703;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tD0Lls83Il+mQLYthxWqSv/YIy5kSUrF6JCqhkv/8Wo=;
        b=cM7bHHsALSk6iv1+SG0uxFelmP5eaeWSkHH0e/mLRVIryS+D26ZxLrhi3RLYs1CjoQ
         o61LSJajXptMclW1E7TKI89xI9kUYI4OoFzK0j3GsomNm7fs/WUKOj0mxIaSCB8ORf4a
         8f893lZ3X2lgAGCJZbp0Xe3IdgqORYHEMs9ZmCudnmMbLqf2QpzB3IWbrU9hCJwa0x0I
         sShiYK+iOC/w0+Y7xDWEzjcNVF60sMasykXGHeRIVvSvmFYiB1POyQ21xQo9fApf1ysb
         Nkyms5e6bC5Ztdcwbrg7L7MTRqTnyqz/Ye88g9LKwcz2a/sNdc9JiaD3En8tj+lvAN7k
         O5yA==
X-Forwarded-Encrypted: i=1; AKwUvByxKGpdpNdtVEvr4lRhrGfZJmti5GykJHihh9NlyHIo8Z3/PPfKn0gXFBKcYZ6Z4Rpaf/lnOaWti2Mickg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKAWep6LHNxm5StAuMWs7jM9otSMXBMi16Ll2ce6gvE1sXKX4ny
	GdgYg3hVa8nzK2DVukglALOu2YdbIFe02yi5k+BDACCFeIsqzx68nNq+BA+prS53l53fi62UeW/
	3b1o9IS411FpDJWUVLY68FcJLHXFpUd0=
X-Gm-Gg: AYBFou1ueCK1TzIAl7FwnM9KKZOYGGQ/0OkY62CQUowGCpZHUjKTxOpDpPMF94bzp5W
	SaByRkZciJCqQZRVg29JZyfZOUYTKb3fNJrTrJvCCcc2OBx8CYkjv8E5ZdvPx5z4DXFs89Hpj43
	Ls7KJXjtIMMYeyw67UXxqjfffL3mFv3Onn7hzOUmdOegUuTLJCCwGFM8anIbazcNj4C6VEky8k4
	1ij8S+kUuEnBusRCIVINabiChqXb5UpBtAd2lNq8Le4EXdqJk8d6SbERtzNN3+fV1uCP/Xw96Ar
	e3V3J4aZKVpxcmXyokxcywhGWh4z3HEm6/OTWR8ssthMbdIXcRCnzEL/AdWhYFeIuxFKi0+CGyG
	WhxnF7Sn0f7ZXYO2y03cE1s+6mLem2W+A8qELtg==
X-Received: by 2002:a05:690c:c50e:b0:8aa:148:7706 with SMTP id
 00721157ae682-8b1669caf65mr45460507b3.8.1793012902608; Mon, 26 Oct 2026
 04:08:22 -0700 (PDT)
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
References: <CAD_a9macSzuBsmmoLu2Cu1doLADvcpASFi-6ADnOvmMdgDEfHA@mail.gmail.com>
In-Reply-To: <CAD_a9macSzuBsmmoLu2Cu1doLADvcpASFi-6ADnOvmMdgDEfHA@mail.gmail.com>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Mon, 26 Oct 2026 16:38:11 +0530
X-Gm-Features: AclHuK8Cpr6C86Ogdt3iNPcZespgzJH98h_TGBqL0O48_bvZRHN6DW3ckIu6Ds0
Message-ID: <CAMFFDGgygzu3OdFkq6+ztZOzaFMMTdYFqtkvmOtHNovQvabXQA@mail.gmail.com>
Subject: Re: [OpenBMC] Guidance on Getting Started with OpenBMC and Choosing a
 Development Board
To: KAVYA M M <kavyamadarsh@gmail.com>
Cc: openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org, 
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Kavya,

Thanks for sharing your platform details and starting a separate thread.

I am also Working On OpenBMC through ASRock Rack B650D4U enablement.
My work is still in progress, and I have not worked on the Gigabyte
MZ32-AR0 or evaluated development boards within your budget, so I
cannot recommend a specific platform confidently.

For the vendor-restricted shell, I would suggest contacting Gigabyte
support about supported debugging access and recovery procedures.

My practical recovery experience is limited to the ASRock Rack B650D4U
that I am currently working on. I use a CH341A external SPI flash
programmer for BMC firmware recovery.

I have not worked on the Gigabyte MZ32-AR0, so I cannot confirm its
recovery procedure or programmer compatibility. Please verify the
flash device, required voltage, and board-specific recovery
instructions before attempting external programming.

On Mon, Oct 26, 2026 at 4:07=E2=80=AFPM KAVYA M M <kavyamadarsh@gmail.com> =
wrote:
>
> Hello OpenBMC Team,
>
> I am new to OpenBMC development and would appreciate your guidance on get=
ting started with developing and validating an OpenBMC image for a server p=
latform.
>
> I have a few general questions:
>
> 1. What hardware documentation is normally required to develop a reliable=
 OpenBMC image for a new motherboard? Are the user manual and BMC reference=
 schematic sufficient, or are the complete motherboard schematic and board-=
specific signal mappings essential?
> 2. If the original BMC firmware is available only as a binary and the mot=
herboard schematic is unavailable, what is the recommended approach for ide=
ntifying the hardware configuration and developing the initial image?
> 3. Which existing OpenBMC reference platforms are suitable for beginners =
who want to learn the Yocto/BitBake build system, device trees, machine con=
figuration, sensor integration, and required services?
> 4. Which hardware platforms provide good support for testing sensor monit=
oring, fan PWM/tachometer control, Redfish, GPIO, host power control, and p=
ower sequencing?
> 5. Which functions can be tested in QEMU, and what hardware documentation=
 and recovery facilities are necessary before proceeding with physical-boar=
d testing?
>
> Request for Guidance on Restricted BMC SSH Access
>
> I would also like to understand how to access the underlying Linux shell =
on a BMC when SSH access is restricted by the vendor firmware.
>
> For example, some BMCs provide SSH access but expose only a restricted in=
terface, such as SMASH-CLP, instead of a standard Linux shell. In such case=
s, what is the recommended and authorized method for accessing the underlyi=
ng Linux environment for debugging, inspecting system configuration, and un=
derstanding the running services?
>
> Are there standard OpenBMC debugging methods or configuration options for=
 enabling SSH shell access during development? If access is restricted by t=
he vendor firmware, what documentation or permissions would be required to =
investigate this further?
>
> My current hardware
>
> I currently have access to a Gigabyte MZ32-AR0-00 motherboard with an ASP=
EED AST2500 BMC.
>
> I am considering using this board for my OpenBMC development. However, I =
do not have access to the complete motherboard schematic, and some board-sp=
ecific hardware mappings are difficult to confirm from the available docume=
ntation and original vendor firmware.
>
> I would appreciate your advice on whether this is a suitable platform for=
 learning and developing OpenBMC, or whether a different, better-documented=
 development platform would be a more practical starting point.
>
> Request for development-board recommendations
>
> My budget for purchasing a BMC development board is approximately =E2=82=
=B95,000=E2=80=93=E2=82=B910,000.
>
> Could you recommend a specific development board or server motherboard th=
at is affordable, well documented, and preferably has an existing upstream =
OpenBMC machine configuration?
>
> Ideally, I would like a platform that supports learning and testing:
>
> - OpenBMC image building using Yocto/BitBake.
> - Hardware sensor monitoring and integration.
> - Fan PWM/tachometer control and cooling failsafe behavior.
> - Redfish and other BMC management interfaces.
> - GPIO, host power control, and power sequencing.
> - QEMU-based software testing followed by physical-board validation.
>
> My preference is for a platform with an existing reference implementation=
, accessible hardware documentation, and a reliable firmware recovery metho=
d. Used development boards or server motherboards would also be suitable if=
 they are available within my budget.
>
> My goal is to choose the most practical platform, build and validate an i=
nitial OpenBMC image, and gradually learn the hardware integration process =
before attempting to flash a physical BMC.
>
> I would be grateful for any recommendations on suitable hardware, existin=
g reference platforms, documentation, or practical guidance from developers=
 experienced in OpenBMC platform development.
>
> Thank you for your time and support.
>
> Best regards,
> Kavya M M

