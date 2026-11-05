Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538CD606A31B
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Nov 2026 23:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=V5SU1EJR
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLJPg02wYz2xH7;
	Fri, 06 Nov 2026 10:27:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1035" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793920346;
	cv=pass; b=njWVq6K0hOuaW+wMKEDzijZ13/vSO4flCu2YLuhjR9ij8RvM6SARP0TabF/NBvvxXGugTW3W5OU1L3Wft5Dn3iWQIWw8IZq2mA6miaJKp6J0c8vpHEEwAgAvDFgj0qIpLXKWIRFrdTbC4mnCeghCD4yuNk5zoP2UVNrRLo6QsnjgP17uen4fwCLNDOx3jaDDTIyLQVhCbcspiJQ6DueMl3fK5ENuFcIlIQzqFxLWH4/DyQfJ05g4B9l7Jy4jQuyM9BhMF5TY06aOJayBnOsJbui4F3g18LK1dRK337/VlP3gYxpwRK9c2q1SdIUijvTBSFVTyIgMzTeov4ZtTUhrow==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793920346; c=relaxed/relaxed;
	bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/NspDpPD8sPyy1eC9w5GnNCAkpzlW9xAQxP6jPHRdqGs+igz9MfckcnT2VpOK9mRQyljqT7HvCh5km5yMiRXmIXfefKCfjIHTQ0zSUyR6RX8RXKN71RKOr2qmvbgrC0z1ZZFU4ZIH623H4JuMi3/3u5FmZCLagn7V9YjzEs84RdbNjWBl1ncSWuUaRWYR3vNx+7FNcqOW8Db9Dp/KCqy2iVnkXhW+8ddMMji4alA3bh7ep0pxsqKO8eWCTjNpILb89NYhNelAXvvcLKDPMtz40qBYbzxmQOMFW26MyTcUvV++TVNvyArmNuqTNXR826eD/LZkKE1BR9vq6yxYWI4A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=V5SU1EJR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=V5SU1EJR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLJ483VZgz2xBK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Nov 2026 10:12:23 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso37366a91.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 15:12:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920341; cv=none;
        d=google.com; s=arc-20260327;
        b=JUhdxhNnhCsFO09JyFbq0pkfL/EOoRXKnt8UZIaYYTomfiHt3LVX3SCMYtg7o7ZyWJ
         Fa7Nct5bVYKmCWyK9Ja7YyMV+Cw0tBx4LWuJjG3AOq8wOC0PmBGU7InfafJyKwKgrhcw
         BiNqzGzlaodYT779FFV/+q4sj+aeqFA0sAXtR6kL8ZMDO50ZetRMbiWK6nOTnhf6vDIG
         dnVAl4BzWB9AGppgUoxlO8t/HA3Xo/N7ug8P7O9/MB2Evqws7j0sfkopELR8EOvUY2p/
         xqrxIaCq6+Skf/BPAXdJfc8Su4cPZW6YBBNrOcMsSPLktaVmJ4rkBvmn7zLwhpvRz3cB
         gQfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        fh=+ili4eOSmXwV9ZEZ92iEE4z138baT/Lz9QQLXP7BtvE=;
        b=e7sZfq48NiVSensr9Bokf/Yd1dDjkhLrfAK+QQoNwIFMnbGf8rNcC9GkbxWjVIyYVA
         mbninnsUFD5Eib4hr+eFUbD6F6YA9GGLcBcimmukSZaVD2xiGODnbQnLkmcrTkL5vZMZ
         J0S1NVVl+BV8C3zVd40xe6gZF3eKYcBud1sfPvsATdLEXGXJE9JlOu0/PZofeQw7nnwh
         TKATkeyZPu56ojAs6QJ/cBtF/z19mQMOiPfPVBC5sAhxqnkiPPsL+TrqLMGEIrrZ24Y5
         7MwUOylVc+v6wY86YuMNdQVsmVHcNyT3j9yRgV1GjTfn7JmR5YNzfcoHxJ6tpCtDSUby
         utRg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920341; x=1794525141; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        b=V5SU1EJRaxnmF4es/Q10Y9jvYNFxMuRIrFalZAmWj1FxpPA5vRIGf7BoKAz+vBADwp
         hSGO4B+1in/pBtpht2PdVSVibG2s/ioMxSi1JihRz0hHuaVigjiFTNFk6+GXZOc1YzS0
         gojfL5cEB1x5qUh0tED4Yq3Dx7j0jiGZVo/x8ZD4Ei+ANH+rESwMbltgEyZzuaaGZT4/
         SVNMRcWBYWRpM2UNrrx2XWlqYksGm3dM17Oj8dHyefnS+hFM8mPqpciVZiatl+S3r/K/
         PzKVyNw5R00x9Rf948C29l0nQ6nOgdmU2usspO7xs2o+qu1M3w2X/qV9XKqmbSiX4qiS
         jmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920341; x=1794525141;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        b=FUzBHCQTJKLgWs56kFlZe2ktHodSuaBN4mPLJP9/oyUtiz1au3j31V+naY1tln52wi
         C6K8jo/DUUQW8eCyh2LYcXbu2/mSGH5V1tqLqh5LZrKzituiCfJbw4kiYvvKC/JwQDkX
         D88Dd21086o1nxB7rgxBlXOiADET0+F65MJ226RD9XYFgYlb12Kre+LaphCQXOA0xKef
         jjHmMyVyn2nybDgCONGxZNgGRJM+k8zhiCCjw0eW6jFyGU13yHIQF1BIQVCh/NOkdgFU
         0AdvcCTt6lWFP3r5RF0ZXRL+02jhhtthw5exuff/SGyybPs7KNhfSnCVpfou9TWrtFjt
         +LZA==
X-Forwarded-Encrypted: i=1; AKwUvBw0BYx5l46qaJ3e4TQV/q3VJ0OhpaTYMm28FB1KmfssNu7y7/OGrgjhJTih3hBPShGl0pKzJR39RIISo64=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9XKVjga+bWvhM5wdvtrnMXmQyvWp0Sgen/xvkGD8yxotPraefE
	SciGo1JBDgzN2Bq+Vv7eiVRTwhxtGRuEAaqHzp4HLjpwSt8AFORicLWuquJLJgHEH+/xX+su2Bh
	0GaluTexQ+ppi2OMGlqSTofi6bNb36AIzxjAgVjYz
X-Gm-Gg: AYBFou3PBkyWTW9Q+6eR+DfqvuMdaQb1DydNuDRmjQ426mN5GrTzgMK7agSAT+a4OP/
	aQXzTgVuo+OZdl90Er98qVz4S/oJ/P20GVXIQv1IGpbf8jxC8Ygnrmbz4SkszTnW4Aq7tKK+zmb
	f7xZrJEfOwH2WXJN7D9yZgVTKkYXdeLzwqBDw9/8EWt0n+gNV8kjuZ1InpfZJ97WviR6c9Kr39S
	hMhZVvCcDTznbPE9FDmzRbbEVBnetSCputIPvvjrJyQi3RB98TRG+Xd24cuCvHO9t769clOf1kB
	kokLmiLWyjSHXQuUbuwQ3++gUQRpyvCFHYnQiMgJxx8dhJf2eZ2DvCskbUwMLLAnIHY15kGbEcb
	nyG2D89fhuBt81azjYsYSxdHrfCpLyIXCsL4IhtsGLCnO3S1AA01nNXlqjOmOi3RJXGVw
X-Received: by 2002:a17:90a:d88f:b0:3ac:b867:81df with SMTP id
 98e67ed59e1d1-3b0db6fbe69mr555739a91.39.1793920341210; Thu, 05 Nov 2026
 15:12:21 -0800 (PST)
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
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:12:09 -0500
X-Gm-Features: AclHuK9SAmQ1s59IzUj_GoyUW49QmobrDei9zDR78OY4d10Tcv8mWs8d-l1JUg8
Message-ID: <CAHC9VhQvpFeEJaEyPDaqj8_S752puSaNe0Rn-hxjh=ugCoFsxA@mail.gmail.com>
Subject: Re: [PATCH 00/14] mm: convert further simple mmap hooks to mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>, 
	Sumit Garg <sumit.garg@kernel.org>, Scott Branden <scott.branden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran <richardcochran@gmail.com>, 
	David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, 
	selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 4:06=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Continue the conversion of users of the deprecated f_op->mmap callback to
> f_op->mmap_prepare. Keep things gentle this cycle by targeting simple
> cases.
>
> No functional change intended.
>
> Build tested on x86-64 (allmodconfig, each patch individually), i386,
> arm64 and ppc64le.
>
> <<>>
>
> David, Andrew - I wonder whether one of you guys could take this series
> through your tree? Since it's kernel-wide it seems sensible to take it
> through an mm tree.

Granted I've only properly looked at the SELinux patch (7/14), the
rest I've just skimmed through, but these are all independent patches,
right?  Is there any reason why individual subsystem maintainers
shouldn't just pick up their associated patch?  Yes, perhaps chasing
down individual maintainers is a bit more work, but isn't that the way
this should work?

> Lorenzo Stoakes (ARM) (14):
>       xen/privcmd: convert mmap hook to mmap_prepare
>       KVM: PPC: Book3S: convert spapr TCE mmap hook to mmap_prepare
>       mshv_vtl: convert mmap hooks to mmap_prepare
>       vduse: convert IOVA domain mmap hook to mmap_prepare
>       x86/sgx: convert vepc mmap hook to mmap_prepare
>       udf: convert mmap hook to mmap_prepare
>       selinuxfs: convert mmap hooks to mmap_prepare
>       xen: convert xenstore interface mmap hooks to mmap_prepare
>       soc: aspeed: convert LPC and P2A control mmap hooks to mmap_prepare
>       soc: qcom: rmtfs_mem: convert mmap hook to mmap_prepare
>       tee: convert shm mmap hook to mmap_prepare
>       misc: bcm-vk: convert mmap hook to mmap_prepare
>       ptp: vmclock: convert mmap hook to mmap_prepare
>       vhost-vdpa: convert mmap hook to mmap_prepare
>
>  arch/powerpc/kvm/book3s_64_vio.c        |  6 +++---
>  arch/x86/kernel/cpu/sgx/virt.c          | 15 ++++++++-------
>  drivers/hv/mshv_vtl_main.c              | 14 +++++++-------
>  drivers/misc/bcm-vk/bcm_vk_dev.c        | 20 ++++++++++----------
>  drivers/ptp/ptp_vmclock.c               | 19 +++++++++----------
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c    | 20 +++++++++-----------
>  drivers/soc/aspeed/aspeed-p2a-ctrl.c    | 22 ++++++++--------------
>  drivers/soc/qcom/rmtfs_mem.c            | 22 ++++++++++------------
>  drivers/tee/tee_shm.c                   | 14 +++++++-------
>  drivers/vdpa/vdpa_user/iova_domain.c    | 12 ++++++------
>  drivers/vhost/vdpa.c                    | 23 ++++++++++++-----------
>  drivers/xen/privcmd.c                   | 11 +++++------
>  drivers/xen/xenbus/xenbus_dev_backend.c | 14 ++++++--------
>  drivers/xen/xenfs/xenstored.c           | 14 ++++++--------
>  fs/udf/file.c                           |  8 ++++----
>  security/selinux/selinuxfs.c            | 24 +++++++++++-------------
>  16 files changed, 121 insertions(+), 137 deletions(-)

--=20
paul-moore.com

