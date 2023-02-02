From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 02 Feb 2023 11:37:20 +1030
Subject: [linux-next:master] BUILD REGRESSION
 66eee64b235411d512bed4d672c2d00683239daf
In-Reply-To: <63da97b5.3V1HSQEat507LFIr%lkp@intel.com>
References: <63da97b5.3V1HSQEat507LFIr%lkp@intel.com>
Message-ID: <76f4dea0-9a39-4238-a213-0167477f5d54@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Neal,

On Thu, 2 Feb 2023, at 03:17, kernel test robot wrote:
> tree/branch: 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 
> master
> branch HEAD: 66eee64b235411d512bed4d672c2d00683239daf  Add linux-next 
> specific files for 20230201
>
>
> Unverified Error/Warning (likely false positive, please contact us if 
> interested):
>
> drivers/crypto/aspeed/aspeed-acry.c:295:37: sparse: sparse: incorrect 
> type in assignment (different base types)
> drivers/crypto/aspeed/aspeed-acry.c:305:28: sparse: sparse: cast 
> removes address space '__iomem' of expression
> drivers/crypto/aspeed/aspeed-acry.c:606:24: sparse: sparse: symbol 
> 'aspeed_acry_akcipher_algs' was not declared. Should it be static?

Can you please look into these issues with the ACRY driver?

Cheers,

Andrew

>
> elapsed time: 722m
>
> configs tested: 69
> configs skipped: 2
>
> gcc tested configs:
> x86_64                          rhel-8.3-func
> x86_64                    rhel-8.3-kselftests
> ia64                             allmodconfig
> x86_64                            allnoconfig
> um                             i386_defconfig
> um                           x86_64_defconfig
> arc                                 defconfig
> i386                                defconfig
> x86_64                              defconfig
> alpha                               defconfig
> arm                                 defconfig
> mips                             allyesconfig
> x86_64                           rhel-8.3-syz
> x86_64               randconfig-a001-20230130
> x86_64                         rhel-8.3-kunit
> x86_64               randconfig-a003-20230130
> x86_64                           rhel-8.3-bpf
> powerpc                           allnoconfig
> x86_64               randconfig-a004-20230130
> x86_64                               rhel-8.3
> x86_64               randconfig-a002-20230130
> powerpc                          allmodconfig
> sh                               allmodconfig
> x86_64               randconfig-a006-20230130
> x86_64                           allyesconfig
> i386                          randconfig-a001
> x86_64                           rhel-8.3-kvm
> i386                          randconfig-a003
> x86_64               randconfig-a005-20230130
> arm64                            allyesconfig
> i386                             allyesconfig
> i386                          randconfig-a005
> arc                  randconfig-r043-20230129
> i386                          randconfig-c001
> arm                              allyesconfig
> s390                                defconfig
> s390                             allmodconfig
> arm                  randconfig-r046-20230129
> arm                  randconfig-r046-20230130
> s390                             allyesconfig
> arc                  randconfig-r043-20230130
> m68k                             allyesconfig
> m68k                             allmodconfig
> alpha                            allyesconfig
> arc                              allyesconfig
>
> clang tested configs:
> x86_64                          rhel-8.3-rust
> x86_64               randconfig-a012-20230130
> x86_64               randconfig-a013-20230130
> x86_64               randconfig-a011-20230130
> x86_64               randconfig-a014-20230130
> i386                 randconfig-a013-20230130
> i386                          randconfig-a002
> i386                 randconfig-a012-20230130
> i386                 randconfig-a014-20230130
> i386                          randconfig-a004
> x86_64               randconfig-a015-20230130
> i386                 randconfig-a015-20230130
> x86_64               randconfig-a016-20230130
> i386                 randconfig-a011-20230130
> hexagon              randconfig-r041-20230129
> i386                 randconfig-a016-20230130
> riscv                randconfig-r042-20230129
> i386                          randconfig-a006
> riscv                randconfig-r042-20230130
> hexagon              randconfig-r045-20230130
> hexagon              randconfig-r041-20230130
> hexagon              randconfig-r045-20230129
> s390                 randconfig-r044-20230129
> s390                 randconfig-r044-20230130
>
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
