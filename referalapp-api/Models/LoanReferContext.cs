using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Pomelo.EntityFrameworkCore.MySql.Scaffolding.Internal;

namespace ReferalApp.Models;

public partial class LoanReferContext : DbContext
{
    public LoanReferContext()
    {
    }

    public LoanReferContext(DbContextOptions<LoanReferContext> options)
        : base(options)
    {
    }

    public virtual DbSet<DesignationMaster> DesignationMasters { get; set; }

    public virtual DbSet<DocumentTypeMaster> DocumentTypeMasters { get; set; }

    public virtual DbSet<EmailIdVerification> EmailIdVerifications { get; set; }

    public virtual DbSet<EmployeeActiveLog> EmployeeActiveLogs { get; set; }

    public virtual DbSet<EmployeeDetail> EmployeeDetails { get; set; }

    public virtual DbSet<Lead> Leads { get; set; }

    public virtual DbSet<LeadAssignment> LeadAssignments { get; set; }

    public virtual DbSet<LeadPayout> LeadPayouts { get; set; }

    public virtual DbSet<LeadsStatusMaster> LeadsStatusMasters { get; set; }

    public virtual DbSet<LoanCommissionMaster> LoanCommissionMasters { get; set; }

    public virtual DbSet<LoanTypeMaster> LoanTypeMasters { get; set; }

    public virtual DbSet<PayoutPercentageMaster> PayoutPercentageMasters { get; set; }

    public virtual DbSet<RefererDetail> RefererDetails { get; set; }

    public virtual DbSet<RefererDocument> RefererDocuments { get; set; }

    public virtual DbSet<RefererPayout> RefererPayouts { get; set; }

    public virtual DbSet<SmtpDetail> SmtpDetails { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseMySql("server=68.178.168.248;port=8802;database=LoanRefer;user id=sysmedac;password=Sysmedac@2023!", Microsoft.EntityFrameworkCore.ServerVersion.Parse("8.0.34-mysql"));

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder
            .UseCollation("utf8mb4_0900_ai_ci")
            .HasCharSet("utf8mb4");

        modelBuilder.Entity<DesignationMaster>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("DesignationMaster");

            entity.Property(e => e.Designation).HasMaxLength(100);
            entity.Property(e => e.Status).HasMaxLength(10);
        });

        modelBuilder.Entity<DocumentTypeMaster>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("DocumentTypeMaster");

            entity.Property(e => e.DocumentType).HasMaxLength(100);
            entity.Property(e => e.Status).HasMaxLength(10);
        });

        modelBuilder.Entity<EmailIdVerification>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("EmailIdVerification");

            entity.Property(e => e.EmailId).HasMaxLength(250);
            entity.Property(e => e.ExpiryDate).HasColumnType("datetime");
            entity.Property(e => e.VerficationCode).HasMaxLength(20);
        });

        modelBuilder.Entity<EmployeeActiveLog>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("EmployeeActiveLog");

            entity.HasIndex(e => e.EmployeeDetailsId, "EmployeeDet_FK_EmpActivity_idx");

            entity.Property(e => e.LoginDate).HasColumnType("datetime");
            entity.Property(e => e.LogoutDate).HasColumnType("datetime");

            entity.HasOne(d => d.EmployeeDetails).WithMany(p => p.EmployeeActiveLogs)
                .HasForeignKey(d => d.EmployeeDetailsId)
                .HasConstraintName("EmployeeDet_FK_EmpActivity");
        });

        modelBuilder.Entity<EmployeeDetail>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.HasIndex(e => e.DesignationMasterId, "fk_DesignationMaster_EmployeeDetails_idx");

            entity.Property(e => e.EmployeeName).HasMaxLength(100);
            entity.Property(e => e.EmployeeNumber).HasMaxLength(50);
            entity.Property(e => e.LastUpdatedAt).HasColumnType("datetime");
            entity.Property(e => e.Password).HasMaxLength(500);
            entity.Property(e => e.Status).HasMaxLength(10);
            entity.Property(e => e.UserName).HasMaxLength(100);

            entity.HasOne(d => d.DesignationMaster).WithMany(p => p.EmployeeDetails)
                .HasForeignKey(d => d.DesignationMasterId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_DesignationMaster_EmployeeDetails");
        });

        modelBuilder.Entity<Lead>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("Lead");

            entity.HasIndex(e => e.LoanTypeMasterId, "fk_LoanTypeMaster_Lead_idx");

            entity.HasIndex(e => e.RefererDetailsId, "fk_RefererDetails_Lead_idx");

            entity.Property(e => e.Address).HasMaxLength(250);
            entity.Property(e => e.AnnualIncome).HasPrecision(15, 2);
            entity.Property(e => e.ApplicantFirstName).HasMaxLength(100);
            entity.Property(e => e.ApplicantLastName).HasMaxLength(100);
            entity.Property(e => e.CityCode).HasMaxLength(10);
            entity.Property(e => e.CityName).HasMaxLength(250);
            entity.Property(e => e.CountryCode).HasMaxLength(10);
            entity.Property(e => e.CountryName).HasMaxLength(250);
            entity.Property(e => e.DateOfBirth).HasColumnType("datetime");
            entity.Property(e => e.EmailId).HasMaxLength(250);
            entity.Property(e => e.ExpectedLoanAmount).HasPrecision(15, 2);
            entity.Property(e => e.Gender).HasMaxLength(20);
            entity.Property(e => e.LastUpdatedDate).HasColumnType("datetime");
            entity.Property(e => e.LeadCreatedDate).HasColumnType("datetime");
            entity.Property(e => e.LeadNumber).HasMaxLength(20);
            entity.Property(e => e.LeadsStatusMasterId).HasColumnName("LeadsStatusMasterID");
            entity.Property(e => e.LoanPurpose).HasMaxLength(1000);
            entity.Property(e => e.MaritalStatus).HasMaxLength(20);
            entity.Property(e => e.MobileNumber).HasMaxLength(20);
            entity.Property(e => e.OrganizationName).HasMaxLength(250);
            entity.Property(e => e.OrganizationType).HasMaxLength(100);
            entity.Property(e => e.PanNumber).HasMaxLength(20);
            entity.Property(e => e.Pincode).HasMaxLength(10);
            entity.Property(e => e.ResidentialType).HasMaxLength(50);
            entity.Property(e => e.StateCode).HasMaxLength(10);
            entity.Property(e => e.StateName).HasMaxLength(250);

            entity.HasOne(d => d.LoanTypeMaster).WithMany(p => p.Leads)
                .HasForeignKey(d => d.LoanTypeMasterId)
                .HasConstraintName("fk_LoanTypeMaster_Lead");

            entity.HasOne(d => d.RefererDetails).WithMany(p => p.Leads)
                .HasForeignKey(d => d.RefererDetailsId)
                .HasConstraintName("fk_RefererDetails_Lead");
        });

        modelBuilder.Entity<LeadAssignment>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("LeadAssignment");

            entity.HasIndex(e => e.LeadId, "LeadAsign_FK_Lead_idx");

            entity.HasIndex(e => e.AssignedTo, "fk_LeadAssignment_Employee_idx");

            entity.Property(e => e.AssignedDate).HasColumnType("datetime");

            entity.HasOne(d => d.AssignedToNavigation).WithMany(p => p.LeadAssignments)
                .HasForeignKey(d => d.AssignedTo)
                .HasConstraintName("fk_LeadAssignment_Employee");

            entity.HasOne(d => d.Lead).WithMany(p => p.LeadAssignments)
                .HasForeignKey(d => d.LeadId)
                .HasConstraintName("LeadAsign_FK_Lead");
        });

        modelBuilder.Entity<LeadPayout>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("LeadPayout");

            entity.HasIndex(e => e.LeadId, "LeadPayout_FK_Lead_idx");

            entity.HasIndex(e => e.LoanTypeMasterId, "LeadPayout_FK_LoanTypeMaster_idx");

            entity.HasIndex(e => e.LeadStatusMasterId, "fk_LeadPayout_LeadStatusMaster_idx");

            entity.Property(e => e.Commission).HasPrecision(17, 2);
            entity.Property(e => e.CommissionType).HasMaxLength(20);
            entity.Property(e => e.DisbursedAmount).HasPrecision(17, 2);
            entity.Property(e => e.DisbursedDate).HasColumnType("datetime");
            entity.Property(e => e.InsertedDate).HasColumnType("datetime");
            entity.Property(e => e.InvoiceUrl).HasMaxLength(500);
            entity.Property(e => e.LastUpdatedDate).HasColumnType("datetime");
            entity.Property(e => e.SignedInvoiceUrl).HasMaxLength(500);
            entity.Property(e => e.TransactionAmount).HasPrecision(17, 2);
            entity.Property(e => e.TransactionDate).HasColumnType("datetime");
            entity.Property(e => e.TransactionRefDocumentUrl).HasMaxLength(500);

            entity.HasOne(d => d.Lead).WithMany(p => p.LeadPayouts)
                .HasForeignKey(d => d.LeadId)
                .HasConstraintName("LeadPayout_FK_Lead");

            entity.HasOne(d => d.LeadStatusMaster).WithMany(p => p.LeadPayouts)
                .HasForeignKey(d => d.LeadStatusMasterId)
                .HasConstraintName("fk_LeadPayout_LeadStatusMaster");

            entity.HasOne(d => d.LoanTypeMaster).WithMany(p => p.LeadPayouts)
                .HasForeignKey(d => d.LoanTypeMasterId)
                .HasConstraintName("LeadPayout_FK_LoanTypeMaster");
        });

        modelBuilder.Entity<LeadsStatusMaster>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("LeadsStatusMaster");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.Status).HasMaxLength(20);
            entity.Property(e => e.StatusType).HasMaxLength(100);
            entity.Property(e => e.Type).HasMaxLength(20);
        });

        modelBuilder.Entity<LoanCommissionMaster>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("LoanCommissionMaster");

            entity.HasIndex(e => e.LoanTypeMasterId, "LoanCOmmission_FK_LoanTypeMaster_idx");

            entity.Property(e => e.Amount).HasPrecision(15, 2);
            entity.Property(e => e.Commission).HasPrecision(17, 2);
            entity.Property(e => e.CommissionType).HasMaxLength(20);
            entity.Property(e => e.InsertedDate).HasColumnType("datetime");
            entity.Property(e => e.LastUpdatedDate).HasColumnType("datetime");
            entity.Property(e => e.Status).HasMaxLength(20);

            entity.HasOne(d => d.LoanTypeMaster).WithMany(p => p.LoanCommissionMasters)
                .HasForeignKey(d => d.LoanTypeMasterId)
                .HasConstraintName("LoanCOmmission_FK_LoanTypeMaster");
        });

        modelBuilder.Entity<LoanTypeMaster>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("LoanTypeMaster");

            entity.Property(e => e.LoanType).HasMaxLength(100);
            entity.Property(e => e.Status).HasMaxLength(10);
        });

        modelBuilder.Entity<PayoutPercentageMaster>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("PayoutPercentageMaster");

            entity.Property(e => e.Percentage).HasPrecision(10, 2);
            entity.Property(e => e.Status).HasMaxLength(10);
        });

        modelBuilder.Entity<RefererDetail>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.Property(e => e.AccountHolderName).HasMaxLength(250);
            entity.Property(e => e.AccountNumber).HasMaxLength(50);
            entity.Property(e => e.BankName).HasMaxLength(100);
            entity.Property(e => e.DateOfBirth).HasColumnType("datetime");
            entity.Property(e => e.EmailId).HasMaxLength(250);
            entity.Property(e => e.FirstName).HasMaxLength(100);
            entity.Property(e => e.IfscCode).HasMaxLength(50);
            entity.Property(e => e.LastName).HasMaxLength(100);
            entity.Property(e => e.LastUpdatedAt).HasColumnType("datetime");
            entity.Property(e => e.MobileNumber).HasMaxLength(20);
            entity.Property(e => e.NoteDetails).HasMaxLength(200);
            entity.Property(e => e.PanNumber).HasMaxLength(20);
            entity.Property(e => e.Password).HasMaxLength(500);
            entity.Property(e => e.ProfilePicUrl).HasMaxLength(500);
            entity.Property(e => e.RefererId).HasMaxLength(50);
            entity.Property(e => e.SignupDate).HasColumnType("datetime");
            entity.Property(e => e.Status).HasMaxLength(20);
        });

        modelBuilder.Entity<RefererDocument>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.HasIndex(e => e.DocumentTypeMasterId, "fk_DocumentTypeMaster_RefererDocuments_idx");

            entity.HasIndex(e => e.RefererDetailsId, "fk_RefererDetails_RefererDocuments_idx");

            entity.Property(e => e.DocumentUrl).HasMaxLength(250);

            entity.HasOne(d => d.DocumentTypeMaster).WithMany(p => p.RefererDocuments)
                .HasForeignKey(d => d.DocumentTypeMasterId)
                .HasConstraintName("fk_DocumentTypeMaster_RefererDocuments");

            entity.HasOne(d => d.RefererDetails).WithMany(p => p.RefererDocuments)
                .HasForeignKey(d => d.RefererDetailsId)
                .HasConstraintName("fk_RefererDetails_RefererDocuments");
        });

        modelBuilder.Entity<RefererPayout>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("RefererPayout");

            entity.HasIndex(e => e.RefererDetailsId, "fk1_ReferrePayout_RefreerDetails_idx");

            entity.HasIndex(e => e.PayoutPercentageMaster, "fk2_ReferrePayout_PayoutPercentageMaster_idx");

            entity.Property(e => e.BalancePayout).HasPrecision(15, 2);
            entity.Property(e => e.CreatedDate).HasColumnType("datetime");
            entity.Property(e => e.SanctionedPayout).HasPrecision(15, 2);
            entity.Property(e => e.TotalPayout).HasPrecision(15, 2);
            entity.Property(e => e.TransactionDate).HasColumnType("datetime");
            entity.Property(e => e.TransactionDocumentUrl).HasMaxLength(250);
            entity.Property(e => e.TransactionNumber).HasMaxLength(20);
            entity.Property(e => e.UpdatedDate).HasColumnType("datetime");

            entity.HasOne(d => d.PayoutPercentageMasterNavigation).WithMany(p => p.RefererPayouts)
                .HasForeignKey(d => d.PayoutPercentageMaster)
                .HasConstraintName("fk2_ReferrePayout_PayoutPercentageMaster");

            entity.HasOne(d => d.RefererDetails).WithMany(p => p.RefererPayouts)
                .HasForeignKey(d => d.RefererDetailsId)
                .HasConstraintName("fk1_ReferrePayout_RefreerDetails");
        });

        modelBuilder.Entity<SmtpDetail>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.Property(e => e.SmtpDomainName).HasMaxLength(150);
            entity.Property(e => e.Smtppassword).HasMaxLength(150);
            entity.Property(e => e.Smtpuseremail).HasMaxLength(150);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
